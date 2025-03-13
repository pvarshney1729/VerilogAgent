module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);
    logic [2:0] state;

    always @(posedge clk) begin
        if (state == 3'b000 && a == 1'b1) begin
            state <= 3'b000; // Stay in state 0
        end else if (state == 3'b000 && a == 1'b0) begin
            state <= 3'b001; // Move to state 1
        end else if (state == 3'b001 && a == 1'b0) begin
            state <= 3'b010; // Move to state 2
        end else if (state == 3'b010 && a == 1'b0) begin
            state <= 3'b011; // Move to state 3
        end else if (state == 3'b011 && a == 1'b0) begin
            state <= 3'b100; // Move to state 4
        end else if (state == 3'b100 && a == 1'b0) begin
            state <= 3'b000; // Move back to state 0
        end else begin
            state <= state; // Hold state
        end
    end

    assign q = state;

endmodule