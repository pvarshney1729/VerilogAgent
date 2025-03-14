[BEGIN]
module TopModule (
    input  logic clk,
    input  logic d,
    input  logic rst,
    output logic q
);

    logic intermediate;
    logic next_q;

    // Rising edge flip-flop for capturing d
    always @(posedge clk) begin
        if (rst) begin
            intermediate <= 1'b0;
        end else begin
            intermediate <= d;
        end
    end

    // Combinational logic to determine next state of q
    always @(*) begin
        if (rst) begin
            next_q = 1'b0;
        end else begin
            next_q = intermediate;
        end
    end

    // Falling edge flip-flop for updating q
    always @(negedge clk) begin
        q <= next_q;
    end

endmodule
[DONE]