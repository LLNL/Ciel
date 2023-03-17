/*
 * (C) Copyright 1988- ECMWF.
 *
 * This software is licensed under the terms of the Apache Licence Version 2.0
 * which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
 * In applying this licence, ECMWF does not waive the privileges and immunities
 * granted to it by virtue of its status as an intergovernmental organisation
 * nor does it submit to any jurisdiction.
 */

#include "cloudsc_driver.h"

#include <omp.h>
#include "mycpu.h"


#define min(a, b) (((a) < (b)) ? (a) : (b))
#define max(a, b) (((a) > (b)) ? (a) : (b))

void cloudsc_driver(int numthreads, int numcols, int nproma) {

  double *tend_tmp_u;
  double *tend_tmp_v;
  double *tend_tmp_t;
  double *tend_tmp_q;
  double *tend_tmp_o3;
  double *tend_tmp_a;
  double *tend_tmp_cld;

  double *tend_loc_u;
  double *tend_loc_v;
  double *tend_loc_t;
  double *tend_loc_q;
  double *tend_loc_o3;
  double *tend_loc_a;
  double *tend_loc_cld;

  double *tend_cml_u;
  double *tend_cml_v;
  double *tend_cml_t;
  double *tend_cml_q;
  double *tend_cml_o3;
  double *tend_cml_a;
  double *tend_cml_cld;

  double ptsphy;            //! Physics timestep

  double *plcrit_aer;
  double *picrit_aer;
  double *pre_ice;
  double *pccn;       //! liquid cloud condensation nuclei
  double *pnice;     //! ice number concentration (cf. CCN)
  double *pt;           //! T at start of callpar
  double *pq;           //! Q at start of callpar
  double *pvfa;       //! CC from VDF scheme
  double *pvfl;       //! Liq from VDF scheme
  double *pvfi;       //! Ice from VDF scheme
  double *pdyna;     //! CC from Dynamics
  double *pdynl;     //! Liq from Dynamics
  double *pdyni;     //! Liq from Dynamics
  double *phrsw;     //! Short-wave heating rate
  double *phrlw;     //! Long-wave heating rate
  double *pvervel; //! Vertical velocity
  double *pap;         //! Pressure on full levels
  double *paph;       //! Pressure on half levels
  double *plsm;           //! Land fraction (0-1) 
  int    *ktype;          //! Convection type 0,1,2
  double *plu;         //! Conv. condensate
  double *plude;     //! Conv. detrained water 
  double *plude_tmp;
  double *psnde;     //! Conv. detrained snow
  double *pmfu;       //! Conv. mass flux up
  double *pmfd;       //! Conv. mass flux down
  double *pa;           //! Original Cloud fraction (t)

  double *pclv;
  double *psupsat;

  double *pcovptot;   //! Precip fraction
  double *prainfrac_toprfz;
  double *pfsqlf;       //! Flux of liquid
  double *pfsqif;       //! Flux of ice
  double *pfcqlng;     //! -ve corr for liq
  double *pfcqnng;     //! -ve corr for ice
  double *pfsqrf;       //! Flux diagnostics
  double *pfsqsf;       //!    for DDH, generic
  double *pfcqrng;     //! rain
  double *pfcqsng;     //! snow
  double *pfsqltur;   //! liquid flux due to VDF
  double *pfsqitur;   //! ice flux due to VDF
  double *pfplsl;       //! liq+rain sedim flux
  double *pfplsn;       //! ice+snow sedim flux
  double *pfhpsl;       //! Enthalpy flux for liq
  double *pfhpsn;       //! Enthalpy flux for ice

  /* Define or query data dimensions from input file */
  int klon, nlev;
  int nblocks = (numcols / nproma) + min(numcols % nproma, 1);

  double zinfo[4][numthreads];
  const double zhpm = 12482329.0;  // IBM P7 HPM flop count for 100 points at L137

  nclv = 5;      // number of microphysics variables
  ncldql = 1;    // liquid cloud water
  ncldqi = 2;    // ice cloud water
  ncldqr = 3;    // rain water
  ncldqs = 4;    // snow
  ncldqv = 5;    // vapour

  yrecldp = (TECLDP*)malloc(sizeof(TECLDP));

  klon = 100; nlev = 137;
  //query_state(&klon, &nlev);
  //printf("klon nlev: %d %d\n", klon, nlev);

  tend_loc_t   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_loc_q   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_loc_a   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_loc_cld = (double*) malloc( sizeof(double) * nblocks*nlev*nproma*nclv );
  tend_cml_t   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_cml_q   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_cml_a   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_cml_cld = (double*) malloc( sizeof(double) * nblocks*nlev*nproma*nclv );
  tend_tmp_t   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_tmp_q   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_tmp_a   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  tend_tmp_cld = (double*) malloc( sizeof(double) * nblocks*nlev*nproma*nclv );

  plcrit_aer = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  picrit_aer = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pre_ice    = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pccn       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pnice      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pt         = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pq         = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pvfa       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pvfl       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pvfi       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pdyna      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pdynl      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pdyni      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  phrsw      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  phrlw      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pvervel    = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pap        = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  paph       = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  plsm       = (double*) malloc( sizeof(double) * nblocks*nproma );
  ktype      = (int*) malloc( sizeof(int) * nblocks*nproma );
  plu        = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  plude      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  psnde      = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pmfu       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pmfd       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pa         = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pclv       = (double*) malloc( sizeof(double) * nblocks*nlev*nproma*nclv );
  psupsat    = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );
  pcovptot   = (double*) malloc( sizeof(double) * nblocks*nlev*nproma );

  prainfrac_toprfz = (double*) malloc( sizeof(double) * nblocks*nproma );
  pfsqlf    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfsqif    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfcqnng   = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfcqlng   = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfsqrf    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfsqsf    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfcqrng   = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfcqsng   = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfsqltur  = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfsqitur  = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfplsl    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfplsn    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfhpsl    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );
  pfhpsn    = (double*) malloc( sizeof(double) * nblocks*(nlev+1)*nproma );

  /*load_state(klon, nlev, nclv, numcols, nproma, &ptsphy, plcrit_aer, picrit_aer,
	     pre_ice, pccn, pnice, pt, pq,
	     tend_cml_t, tend_cml_q, tend_cml_a, tend_cml_cld,
	     tend_tmp_t, tend_tmp_q, tend_tmp_a, tend_tmp_cld,
	     pvfa, pvfl, pvfi, pdyna, pdynl, pdyni,
	     phrsw, phrlw, pvervel, pap, paph, plsm,  ktype, plu,
	     plude, psnde, pmfu, pmfd, pa, pclv, psupsat);*/

  FILE* fd = fopen("load_state.bin", "rb");
  if (fd) {
    fread(plcrit_aer, sizeof(double), nblocks*nlev*nproma, fd);
    fread(picrit_aer, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pre_ice, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pccn, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pnice, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pt, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pq, sizeof(double), nblocks*nlev*nproma, fd);

    fread(tend_cml_t, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_cml_q, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_cml_a, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_cml_cld, sizeof(double), nblocks*nlev*nproma*nclv, fd);
    fread(tend_tmp_t, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_tmp_q, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_tmp_a, sizeof(double), nblocks*nlev*nproma, fd);
    fread(tend_tmp_cld, sizeof(double), nblocks*nlev*nproma*nclv, fd);

    fread(pvfa, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pvfl, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pvfi, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pdyna, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pdynl, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pdyni, sizeof(double), nblocks*nlev*nproma, fd);
    fread(phrsw, sizeof(double), nblocks*nlev*nproma, fd);
    fread(phrlw, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pvervel, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pap, sizeof(double), nblocks*nlev*nproma, fd);
    fread(paph, sizeof(double), nblocks*(nlev+1)*nproma, fd);

    fread(plsm, sizeof(double), nblocks*nproma, fd);
    fread(ktype, sizeof(int), nblocks*nproma, fd);
    fread(plu, sizeof(double), nblocks*nlev*nproma, fd);

    fread(plude, sizeof(double), nblocks*nlev*nproma, fd);
    fread(psnde, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pmfu, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pmfd, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pa, sizeof(double), nblocks*nlev*nproma, fd);
    fread(pclv, sizeof(double), nblocks*nlev*nproma*nclv, fd);
    fread(psupsat, sizeof(double), nblocks*nlev*nproma, fd);

    fread(yrecldp, sizeof(TECLDP), 1, fd);

    fread(&ptsphy, sizeof(double), 1, fd);

    fread(&rg, sizeof(double), 1, fd);
    fread(&rd, sizeof(double), 1, fd);
    fread(&rcpd, sizeof(double), 1, fd);
    fread(&retv, sizeof(double), 1, fd);
    fread(&rlvtt, sizeof(double), 1, fd);
    fread(&rlstt, sizeof(double), 1, fd);
    fread(&rlmlt, sizeof(double), 1, fd);
    fread(&rtt, sizeof(double), 1, fd);
    fread(&rv, sizeof(double), 1, fd);
    fread(&r2es , sizeof(double), 1, fd);
    fread(&r3les, sizeof(double), 1, fd);
    fread(&r3ies, sizeof(double), 1, fd);
    fread(&r4les, sizeof(double), 1, fd);
    fread(&r4ies, sizeof(double), 1, fd);
    fread(&r5les, sizeof(double), 1, fd);
    fread(&r5ies, sizeof(double), 1, fd);
    fread(&r5alvcp, sizeof(double), 1, fd);
    fread(&r5alscp, sizeof(double), 1, fd);
    fread(&ralvdcp, sizeof(double), 1, fd);
    fread(&ralsdcp, sizeof(double), 1, fd);
    fread(&ralfdcp, sizeof(double), 1, fd);
    fread(&rtwat, sizeof(double), 1, fd);
    fread(&rtice, sizeof(double), 1, fd);
    fread(&rticecu, sizeof(double), 1, fd);
    fread(&rtwat_rtice_r, sizeof(double), 1, fd);
    fread(&rtwat_rticecu_r, sizeof(double), 1, fd);
    fread(&rkoop1, sizeof(double), 1, fd);
    fread(&rkoop2, sizeof(double), 1, fd);

    fclose(fd);
  }

  /*FILE* fd = fopen("load_state.bin", "wb");
  if (fd) {
    fwrite(plcrit_aer, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(picrit_aer, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pre_ice, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pccn, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pnice, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pt, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pq, sizeof(double), nblocks*nlev*nproma, fd);

    fwrite(tend_cml_t, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_cml_q, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_cml_a, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_cml_cld, sizeof(double), nblocks*nlev*nproma*nclv, fd);
    fwrite(tend_tmp_t, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_tmp_q, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_tmp_a, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(tend_tmp_cld, sizeof(double), nblocks*nlev*nproma*nclv, fd);

    fwrite(pvfa, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pvfl, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pvfi, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pdyna, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pdynl, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pdyni, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(phrsw, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(phrlw, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pvervel, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pap, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(paph, sizeof(double), nblocks*(nlev+1)*nproma, fd);

    fwrite(plsm, sizeof(double), nblocks*nproma, fd);
    fwrite(ktype, sizeof(int), nblocks*nproma, fd);
    fwrite(plu, sizeof(double), nblocks*nlev*nproma, fd);

    fwrite(plude, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(psnde, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pmfu, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pmfd, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pa, sizeof(double), nblocks*nlev*nproma, fd);
    fwrite(pclv, sizeof(double), nblocks*nlev*nproma*nclv, fd);
    fwrite(psupsat, sizeof(double), nblocks*nlev*nproma, fd);

    fwrite(yrecldp, sizeof(TECLDP), 1, fd);

    fwrite(&ptsphy, sizeof(double), 1, fd);

    fwrite(&rg, sizeof(double), 1, fd);
    fwrite(&rd, sizeof(double), 1, fd);
    fwrite(&rcpd, sizeof(double), 1, fd);
    fwrite(&retv, sizeof(double), 1, fd);
    fwrite(&rlvtt, sizeof(double), 1, fd);
    fwrite(&rlstt, sizeof(double), 1, fd);
    fwrite(&rlmlt, sizeof(double), 1, fd);
    fwrite(&rtt, sizeof(double), 1, fd);
    fwrite(&rv, sizeof(double), 1, fd);
    fwrite(&r2es , sizeof(double), 1, fd);
    fwrite(&r3les, sizeof(double), 1, fd);
    fwrite(&r3ies, sizeof(double), 1, fd);
    fwrite(&r4les, sizeof(double), 1, fd);
    fwrite(&r4ies, sizeof(double), 1, fd);
    fwrite(&r5les, sizeof(double), 1, fd);
    fwrite(&r5ies, sizeof(double), 1, fd);
    fwrite(&r5alvcp, sizeof(double), 1, fd);
    fwrite(&r5alscp, sizeof(double), 1, fd);
    fwrite(&ralvdcp, sizeof(double), 1, fd);
    fwrite(&ralsdcp, sizeof(double), 1, fd);
    fwrite(&ralfdcp, sizeof(double), 1, fd);
    fwrite(&rtwat, sizeof(double), 1, fd);
    fwrite(&rtice, sizeof(double), 1, fd);
    fwrite(&rticecu, sizeof(double), 1, fd);
    fwrite(&rtwat_rtice_r, sizeof(double), 1, fd);
    fwrite(&rtwat_rticecu_r, sizeof(double), 1, fd);
    fwrite(&rkoop1, sizeof(double), 1, fd);
    fwrite(&rkoop2, sizeof(double), 1, fd);

    fclose(fd);
  }*/

  double t1 = omp_get_wtime();

#pragma omp parallel num_threads(numthreads) default(shared)
  {
    int b, bsize, icalls=0, igpc=0;
    int coreid = mycpu();
    int tid = omp_get_thread_num();
    double start = omp_get_wtime();

/* #pragma omp parallel for num_threads(numthreads) default(shared) private(b, bsize) */
#pragma omp for schedule(runtime) nowait
    for (b = 0; b < nblocks; b++) {
      const int idx = b*nlev*nproma;
      const int idxp1 = b*(nlev+1)*nproma;
      const int idx1d = b*nproma;
      const int idx3d = b*nclv*nlev*nproma;
      bsize = min(nproma, numcols - b*nproma);

      for (int i = 0; i < nlev*nproma; i++) { pcovptot[idx+i] = 0.0; }
      for (int i = 0; i < nclv*nlev*nproma; i++) { tend_loc_cld[idx3d+i] = 0.0; }

      cloudsc_c(1, bsize, nproma, nlev, ptsphy, &pt[idx], &pq[idx],
		&tend_cml_t[idx], &tend_cml_q[idx], &tend_cml_a[idx], &tend_cml_cld[idx3d],
		&tend_tmp_t[idx], &tend_tmp_q[idx], &tend_tmp_a[idx], &tend_tmp_cld[idx3d],
		&tend_loc_t[idx], &tend_loc_q[idx], &tend_loc_a[idx], &tend_loc_cld[idx3d],
		&pvfa[idx], &pvfl[idx], &pvfi[idx],
		&pdyna[idx], &pdynl[idx], &pdyni[idx],
		&phrsw[idx], &phrlw[idx], &pvervel[idx],
		&pap[idx], &paph[idxp1], &plsm[idx1d], &ktype[idx1d],
		&plu[idx], &plude[idx], &psnde[idx], &pmfu[idx], &pmfd[idx],
		&pa[idx], &pclv[idx3d], &psupsat[idx],
		&plcrit_aer[idx], &picrit_aer[idx], &pre_ice[idx], &pccn[idx], &pnice[idx],
		&pcovptot[idx], &prainfrac_toprfz[idx1d], &pfsqlf[idxp1],
		&pfsqif[idxp1], &pfcqnng[idxp1], &pfcqlng[idxp1],
		&pfsqrf[idxp1], &pfsqsf[idxp1], &pfcqrng[idxp1],
		&pfcqsng[idxp1], &pfsqltur[idxp1], &pfsqitur[idxp1],
		&pfplsl[idxp1], &pfplsn[idxp1], &pfhpsl[idxp1], &pfhpsn[idxp1]);

      icalls += 1;
      igpc += bsize;
    }

    double end = omp_get_wtime();
    /* int msec = diff * 1000 / CLOCKS_PER_SEC; */
    zinfo[0][tid] = end - start;
    zinfo[1][tid] = (double) coreid;
    zinfo[2][tid] = (double) icalls;
    zinfo[3][tid] = (double) igpc;
  }

  double t2 = omp_get_wtime();

  printf("     NUMOMP=%d, NGPTOT=%d, NPROMA=%d, NGPBLKS=%d\n", numthreads, numcols, nproma, nblocks);
  printf(" %+10s%+10s%+10s%+10s%+10s %+4s : %+10s%+10s\n",
    "NUMOMP", "NGPTOT", "#GP-cols", "#BLKS", "NPROMA", "tid#", "Time(msec)", "MFlops/s");
  double zfrac, zmflops;
  for (int t = 0; t < numthreads; t++) {
    const double tloc = zinfo[0][t];
    const int coreid = (int) zinfo[1][t];
    const int icalls = (int) zinfo[2][t];
    const int igpc = (int) zinfo[3][t];
    zfrac = (double)igpc / (double)numcols;
    if (tloc > 0.0) {
      zmflops = 1.0e-06 * zfrac * zhpm * ((double)numcols / 100.) / tloc;
    } else {
      zmflops = 0.;
    }
    printf(" %10d%10d%10d%10d%10d %4d : %10d%10d @ core#\n",
	   numthreads, numcols, igpc, icalls, nproma, t, (int)(tloc * 1000.), (int)zmflops);
  }
  double tdiff = t2 - t1;
  zfrac = 1.0;
  if (tdiff > 0.0) {
    zmflops = 1.0e-06 * zfrac * zhpm * ((double)numcols / 100.) / tdiff;
  } else {
    zmflops = 0.0;
  }
  printf(" %10d%10d%10d%10d%10d %4d : %10d%10d TOTAL\n",
	 numthreads, numcols, numcols, nblocks, nproma, -1, (int)(tdiff * 1000.), (int)zmflops);

  cloudsc_validate(klon, nlev, nclv, numcols, nproma,
		   plude, pcovptot, prainfrac_toprfz, pfsqlf, pfsqif,
		   pfcqlng, pfcqnng, pfsqrf, pfsqsf, pfcqrng, pfcqsng,
		   pfsqltur, pfsqitur, pfplsl, pfplsn, pfhpsl, pfhpsn,
		   tend_loc_a, tend_loc_q, tend_loc_t, tend_loc_cld);

  free(plcrit_aer); // ALLOCATE(PLCRIT_AER(KLON,KLEV)) 
  free(picrit_aer); // ALLOCATE(PICRIT_AER(KLON,KLEV)) 
  free(pre_ice);    // ALLOCATE(PRE_ICE(KLON,KLEV)) 
  free(pccn);
  free(pnice);
  free(pt);
  free(pq);
  free(pvfa);
  free(pvfl);
  free(pvfi);
  free(pdyna);
  free(pdynl);
  free(pdyni);
  free(phrsw);
  free(phrlw);
  free(pvervel);
  free(pap);
  free(paph); // ALLOCATE(PAPH(KLON,KLEV+1))
  free(plsm);
  free(ktype);
  free(plu);
  free(plude);
  free(psnde);
  free(pmfu);
  free(pmfd);
  free(pa);
  free(pclv);
  free(psupsat);
  free(pcovptot);
  free(tend_loc_t);
  free(tend_loc_q);
  free(tend_loc_a);
  free(tend_loc_cld);
  free(tend_tmp_t);
  free(tend_tmp_q);
  free(tend_tmp_a);
  free(tend_tmp_cld);
  free(tend_cml_t);
  free(tend_cml_q);
  free(tend_cml_a);
  free(tend_cml_cld);

  free(prainfrac_toprfz);
  free(pfsqlf);
  free(pfsqif);
  free(pfcqnng);
  free(pfcqlng);
  free(pfsqrf);
  free(pfsqsf);
  free(pfcqrng);
  free(pfcqsng);
  free(pfsqltur);
  free(pfsqitur);
  free(pfplsl);
  free(pfplsn);
  free(pfhpsl);
  free(pfhpsn);

  free(yrecldp);
}
