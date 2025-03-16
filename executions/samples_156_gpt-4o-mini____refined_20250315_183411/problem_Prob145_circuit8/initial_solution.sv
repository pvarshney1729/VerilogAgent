module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);
    logic state;
    
    always @(posedge clock) begin
        if (state == 0 && a == 1) begin
            p <= 0;
            q <= 0;
        end else if (state == 0 && a == 0) begin
            p <= 0;
            q <= 0;
        end else if (state == 1 && a == 0) begin
            p <= 1;
            q <= 1;
        end else if (state == 1 && a == 1) begin
            p <= 1;
            q <= 0;
        end
        state <= a;
    end
endmodule