/*
 * (C) Copyright 1988- ECMWF.
 *
 * This software is licensed under the terms of the Apache Licence Version 2.0
 * which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
 * In applying this licence, ECMWF does not waive the privileges and immunities
 * granted to it by virtue of its status as an intergovernmental organisation
 * nor does it submit to any jurisdiction.
 */

#include "yomcst_c.h"
#include "yoethf_c.h"
#include "yoecldp_c.h"

int cloudsc_c(int kidia, int kfdia, int klon, int klev, double ptsphy, double * __restrict v_pt, double * __restrict v_pq,
	      double * __restrict v_tendency_cml_t, double * __restrict v_tendency_cml_q, double * __restrict v_tendency_cml_a, double * __restrict v_tendency_cml_cld,
	      double * __restrict v_tendency_tmp_t, double * __restrict v_tendency_tmp_q, double * __restrict v_tendency_tmp_a, double * __restrict v_tendency_tmp_cld,
	      double * __restrict v_tendency_loc_t, double * __restrict v_tendency_loc_q, double * __restrict v_tendency_loc_a, double * __restrict v_tendency_loc_cld,
	      double * __restrict v_pvfa, double * __restrict v_pvfl, double * __restrict v_pvfi, double * __restrict v_pdyna, double * __restrict v_pdynl, double * __restrict v_pdyni,
	      double * __restrict v_phrsw, double * __restrict v_phrlw, double * __restrict v_pvervel, double * __restrict v_pap, double * __restrict v_paph, double * __restrict v_plsm,
	      int * __restrict v_ktype, double * __restrict v_plu, double * __restrict v_plude, double * __restrict v_psnde, double * __restrict v_pmfu,
	      double * __restrict v_pmfd, double * __restrict v_pa, double * __restrict v_pclv, double * __restrict v_psupsat, double * __restrict v_plcrit_aer, double * __restrict v_picrit_aer,
	      double * __restrict v_pre_ice, double * __restrict v_pccn, double * __restrict v_pnice, double * __restrict v_pcovptot, double * __restrict v_prainfrac_toprfz, double * __restrict v_pfsqlf,
	      double * __restrict v_pfsqif, double * __restrict v_pfcqnng, double * __restrict v_pfcqlng, double * __restrict v_pfsqrf, double * __restrict v_pfsqsf, double * __restrict v_pfcqrng,
	      double * __restrict v_pfcqsng, double * __restrict v_pfsqltur, double * __restrict v_pfsqitur, double * __restrict v_pfplsl, double * __restrict v_pfplsn, double * __restrict v_pfhpsl,
	      double * __restrict v_pfhpsn);
