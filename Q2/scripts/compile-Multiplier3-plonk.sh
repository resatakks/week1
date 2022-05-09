#!/bin/bash

cd contracts/circuits

mkdir Multiplier3-plonk

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling Multiplier3.circom..."

# compile circuit

circom Multiplier3.circom --r1cs --wasm --sym -o Multiplier3-plonk
snarkjs r1cs info Multiplier3-plonk/Multiplier3.r1cs

# Start a new zkey

snarkjs plonk setup Multiplier3-plonk/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau Multiplier3-plonk/circuit_final.zkey
snarkjs zkey export verificationkey Multiplier3-plonk/circuit_final.zkey Multiplier3-plonk/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier Multiplier3-plonk/circuit_final.zkey ../Multiplier3PlonkVerifier.sol

cd ../..