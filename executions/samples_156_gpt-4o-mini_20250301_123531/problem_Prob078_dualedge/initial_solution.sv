module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic q_rise;
    logic q_fall;

    always @(posedge clk) begin
        q_rise <= d;
    end

    always @(negedge clk) begin
        q_fall <= d;
    end

    always @(*) begin
        q = q_rise | q_fall;
    end
endmodule