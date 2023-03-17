#ifndef _CIEL_BASE_H_
#define _CIEL_BASE_H_

// high to low precision
#define copy_vec_element(b, a, c) b.c = double((a).c);

#define init_vec2(b, a) copy_vec_element(b, a, x) copy_vec_element(b, a, y)
#define init_vec3(b, a) copy_vec_element(b, a, x) copy_vec_element(b, a, y) copy_vec_element(b, a, z)
#define init_vec4(b, a) copy_vec_element(b, a, x) copy_vec_element(b, a, y) copy_vec_element(b, a, z) copy_vec_element(b, a, w)

#define define_vec2(type, b, a) type b; init_vec2(b, a)
#define define_vec3(type, b, a) type b; init_vec3(b, a)
#define define_vec4(type, b, a) type b; init_vec4(b, a)

#define make_vec2(type, a) make_##type##2(a.x, a.y)
#define make_vec3(type, a) make_##type##3(a.x, a.y, a.z)
#define make_vec4(type, a) make_##type##4(a.x, a.y, a.z, a.w)

#ifdef __CUDACC__
#define FUNCTION_DECL __host__ __device__
#else
#define FUNCTION_DECL
#endif

template <typename Src, typename Dst >
FUNCTION_DECL Dst ValueConverter(Src dv) {
    Dst b = Dst(dv); return b;
}

template <typename Src, typename Dst >
FUNCTION_DECL Dst ValueConverter2(Src dv) {
    define_vec2(Dst, b, dv); return b;
}

template <typename Src, typename Dst >
FUNCTION_DECL Dst ValueConverter3(Src dv) {
    define_vec3(Dst, b, dv); return b;
}

template <typename Src, typename Dst >
FUNCTION_DECL Dst ValueConverter4(Src dv) {
    define_vec4(Dst, b, dv); return b;
}

template <class Dst, class Src, unsigned int size >
class ArrayConverterHelper {
public:
    FUNCTION_DECL ArrayConverterHelper(Src srcArray[]) {
        this->srcArray = (Src*)srcArray;
        for (unsigned int i = 0; i < size; i++) {
            dstArray[i] = Dst(srcArray[i]);
        }
    }
    FUNCTION_DECL ~ArrayConverterHelper() {
        for (unsigned int i = 0; i < size; i++) {
            srcArray[i] = Src(dstArray[i]);
        }        
    }
    Dst dstArray[size];
    Src* srcArray;
    FUNCTION_DECL Dst* getArray() { return dstArray; }

    FUNCTION_DECL static void Convert(Dst* dst, Src* src) {
        for (unsigned int i = 0; i < size; i++) {
            dst[i] = Dst(src[i]);
        }
    }
};

template <typename Src, typename Dst >
class RefConverter {
public:
    FUNCTION_DECL RefConverter(Src& dv) { 
        this->dv = &dv;
        this->v = Dst(dv);
    }
    FUNCTION_DECL RefConverter(Src* pdv) {
        this->dv = pdv;
        this->v = Dst(*pdv);
    }
    FUNCTION_DECL ~RefConverter() { 
        *dv = Src(v);
    }
    Dst v;
    Src* dv;
    FUNCTION_DECL Dst& ref() { return v; }
    FUNCTION_DECL Dst* ptr() { return &v; }
};

template <typename Src, typename Dst >
class RefConverter2 {
public:
    FUNCTION_DECL RefConverter2(Src& dv) { 
        this->dv = &dv;
        init_vec2(v, dv);
    }
    FUNCTION_DECL RefConverter2(Src* pdv) { 
        this->dv = pdv;
        init_vec2(v, (*pdv));
    }
    FUNCTION_DECL ~RefConverter2() { 
        init_vec2((*dv), v);
    }
    Dst v;
    Src* dv;
    FUNCTION_DECL Dst& ref() { return v; }
    FUNCTION_DECL Dst* ptr() { return &v; }
};

template <typename Src, typename Dst >
class RefConverter3 {
public:
    FUNCTION_DECL RefConverter3(Src& dv) { 
        this->dv = &dv;
        init_vec3(v, dv);
    }
    FUNCTION_DECL RefConverter3(Src* pdv) { 
        this->dv = pdv;
        init_vec3(v, (*pdv));
    }
    FUNCTION_DECL ~RefConverter3() { 
        init_vec3((*dv), v);
    }
    Dst v;
    Src* dv;
    FUNCTION_DECL Dst& ref() { return v; }
    FUNCTION_DECL Dst* ptr() { return &v; }
};

template <typename Src, typename Dst >
class RefConverter4 {
public:
    FUNCTION_DECL RefConverter4(Src& dv) { 
        this->dv = &dv;
        init_vec4(v, dv);
    }
    FUNCTION_DECL RefConverter4(Src* pdv) { 
        this->dv = pdv;
        init_vec4(v, (*pdv));
    }
    FUNCTION_DECL ~RefConverter4() { 
        init_vec4((*dv), v);
    }
    Dst v;
    Src* dv;
    FUNCTION_DECL Dst& ref() { return v; }
    FUNCTION_DECL Dst* ptr() { return &v; }
};

#define ConvertArray(dst, src, a) ArrayConverterHelper<dst, src, sizeof(a)/sizeof(a[0])>(a).getArray()
#define CopyArray(dst, src, b, a) ArrayConverterHelper<dst, src, sizeof(a)/sizeof(a[0])>::Convert(b, a)

#define ConvertRef(dst, src, a) RefConverter<src, dst>(a).ref()
#define ConvertRef2(dst, src, a) RefConverter2<src, dst>(a).ref()
#define ConvertRef3(dst, src, a) RefConverter3<src, dst>(a).ref()
#define ConvertRef4(dst, src, a) RefConverter4<src, dst>(a).ref()

#define ConvertValue(dst, src, a) ValueConverter<src, dst>(a)
#define ConvertValue2(dst, src, a) ValueConverter2<src, dst>(a)
#define ConvertValue3(dst, src, a) ValueConverter3<src, dst>(a)
#define ConvertValue4(dst, src, a) ValueConverter4<src, dst>(a)

#endif // _CIEL_BASE_H_