pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";

template RangeProof(n) {
    assert(n <= 252);
    signal input in; // this is the number to be proved inside the range
    signal input range[2]; // the two elements should be the range, i.e. [lower bound, upper bound]
    signal output out;

    component lower = LessEqThan(n);
    component upper = GreaterEqThan(n);

    // [assignment] insert your code here

        upper.in[0] <== in;
    upper.in[1] <== range[0];

    
    lower.in[0] <== in;
    lower.in[1] <== range[1];

    out <== lower.out * upper.out;
}

/* INPUT={
    "in":"2"
} */