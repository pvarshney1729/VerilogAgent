module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Sequential logic for output p
    always @(posedge clock) begin
        if (a) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
    end

    // Sequential logic for output q
    always @(negedge clock) begin
        q <= p;
    end

endmodule