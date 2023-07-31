use std::{marker::PhantomData, ptr::NonNull};

use halo2_proofs::{arithmetic::Field, pasta::Fp as Halo2Fp};
use haskell_ffi::{from_haskell::marshall_from_haskell_var, to_haskell::marshall_to_haskell_var};

fn to_sized_array<T, const N: usize>(v: Vec<T>) -> [T; N] {
    v.try_into()
        .unwrap_or_else(|v: Vec<T>| panic!("Expected a Vec of length {} but it was {}", N, v.len()))
}

// Tag (to ensure no orphans)
pub enum RW {}

/// cbindgen:ignore
pub const RW: PhantomData<RW> = PhantomData;

#[derive(Debug)]
pub struct Fp(Halo2Fp);

#[no_mangle]
pub extern "C" fn halo2_rs_fp_from_raw(raw_bytes: *const u8, raw_bytes_len: usize) -> *mut Fp {
    let raw_vec: Vec<u64> = marshall_from_haskell_var(raw_bytes, raw_bytes_len, RW);
    let raw: [u64; 4] = to_sized_array(raw_vec);
    let fp = Box::new(Fp(Halo2Fp::from_raw(raw)));
    Box::into_raw(fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_from_raw_args(a1: u64, a2: u64, a3: u64, a4: u64) -> *mut Fp {
    let fp = Box::new(Fp(Halo2Fp::from_raw([a1, a2, a3, a4])));
    Box::into_raw(fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_free_fp(fp: *mut Fp) {
    match NonNull::new(fp) {
        None => return,
        Some(fp_nonnull) => {
            let _fp: Box<Fp> = unsafe { Box::from_raw(fp_nonnull.as_ptr()) };
        }
    }
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_debug(fp: *mut Fp, out: *mut u8, out_len: &mut usize) {
    let fp: &Fp = unsafe { &*fp };
    let result = format!("{:#?}", fp.0);
    marshall_to_haskell_var(&result, out, out_len, RW);
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_eq(fp1: *mut Fp, fp2: *mut Fp) -> bool {
    let fp1: &Fp = unsafe { &*fp1 };
    let fp2: &Fp = unsafe { &*fp2 };
    fp1.0 == fp2.0
}

fn fp_binary_op<F>(op: F, fp1: *mut Fp, fp2: *mut Fp) -> *mut Fp
where
    F: FnOnce(&Halo2Fp, &Halo2Fp) -> Halo2Fp,
{
    let fp1: &Fp = unsafe { &*fp1 };
    let fp2: &Fp = unsafe { &*fp2 };
    let result = Box::new(Fp(op(&fp1.0, &fp2.0)));
    Box::into_raw(result)
}

fn fp_unary_op<F>(op: F, fp: *mut Fp) -> *mut Fp
where
    F: FnOnce(&Halo2Fp) -> Halo2Fp,
{
    let fp: &Fp = unsafe { &*fp };
    let result = Box::new(Fp(op(&fp.0)));
    Box::into_raw(result)
}

fn fp_nullary_op<F>(op: F) -> *mut Fp
where
    F: FnOnce() -> Halo2Fp,
{
    let fp = Box::new(Fp(op()));
    Box::into_raw(fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_invert(fp: *mut Fp) -> Option<NonNull<Fp>> {
    let fp: &Fp = unsafe { &*fp };
    let inv_result = fp.0.invert();
    let inv_option: Option<Halo2Fp> = Option::from(inv_result);
    inv_option.and_then(|x| NonNull::new(Box::into_raw(Box::new(Fp(x)))))
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_zero() -> *mut Fp {
    fp_nullary_op(Halo2Fp::zero)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_one() -> *mut Fp {
    fp_nullary_op(Halo2Fp::one)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_mul(fp1: *mut Fp, fp2: *mut Fp) -> *mut Fp {
    fp_binary_op(Halo2Fp::mul, fp1, fp2)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_sub(fp1: *mut Fp, fp2: *mut Fp) -> *mut Fp {
    fp_binary_op(Halo2Fp::sub, fp1, fp2)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_add(fp1: *mut Fp, fp2: *mut Fp) -> *mut Fp {
    fp_binary_op(Halo2Fp::add, fp1, fp2)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_double(fp: *mut Fp) -> *mut Fp {
    fp_unary_op(Halo2Fp::double, fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_neg(fp: *mut Fp) -> *mut Fp {
    fp_unary_op(Halo2Fp::neg, fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_square(fp: *mut Fp) -> *mut Fp {
    fp_unary_op(Halo2Fp::square, fp)
}
