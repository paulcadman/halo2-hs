use std::marker::PhantomData;

use halo2_proofs::pasta::Fp;
use haskell_ffi::{from_haskell::marshall_from_haskell_var, to_haskell::marshall_to_haskell_var};

#[no_mangle]
pub extern "C" fn halo2_rs_add(x: u64, y: u64) -> u64 {
    x + y
}

fn to_sized_array<T, const N: usize>(v: Vec<T>) -> [T; N] {
    v.try_into()
        .unwrap_or_else(|v: Vec<T>| panic!("Expected a Vec of length {} but it was {}", N, v.len()))
}

// Tag (to ensure no orphans)
pub enum RW {}

/// cbindgen:ignore
pub const RW: PhantomData<RW> = PhantomData;

#[derive(Debug)]
pub struct FpHandle(Fp);

#[no_mangle]
pub extern "C" fn halo2_rs_fp_from_raw(
    raw_bytes: *const u8,
    raw_bytes_len: usize,
) -> *mut FpHandle {
    let raw_vec: Vec<u64> = marshall_from_haskell_var(raw_bytes, raw_bytes_len, RW);
    let raw: [u64; 4] = to_sized_array(raw_vec);
    let fp = Box::new(FpHandle(Fp::from_raw(raw)));
    Box::into_raw(fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_from_raw_args(
    a1: u64,
    a2: u64,
    a3: u64,
    a4: u64,
) -> *mut FpHandle {
    let fp = Box::new(FpHandle(Fp::from_raw([a1, a2, a3, a4])));
    Box::into_raw(fp)
}

#[no_mangle]
pub extern "C" fn halo2_rs_free_fp(fp: *mut FpHandle) {
    let _fp: Box<FpHandle> = unsafe { Box::from_raw(fp) };
}

#[no_mangle]
pub extern "C" fn halo2_rs_fp_debug(fp: *mut FpHandle, out: *mut u8, out_len: &mut usize) {
    let fp: &FpHandle = unsafe { &*fp };
    let result = format!("{:#?}", fp.0);
    marshall_to_haskell_var(&result, out, out_len, RW);
}
