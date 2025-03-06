module TopModule (
    input  logic [2:0] vec,
    output logic [2:0] outv,
    output logic       o0,
    output logic       o1,
    output logic       o2
);

    // Combinational logic to directly map inputs to outputs
    always_comb begin
        outv = vec;
        o0 = vec[0];
        o1 = vec[1];
        o2 = vec[2];
    end

endmodule