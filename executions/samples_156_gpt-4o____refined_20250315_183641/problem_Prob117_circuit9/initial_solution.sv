[BEGIN]
module TopModule (
    input  logic clk,
    input  logic a,
    output logic [2:0] q
);

    logic [2:0] state;
    logic [2:0] next_state;

    always_ff @(posedge clk) begin
        state <= next_state;
    end

    always_comb begin
        if (a) begin
            next_state = 3'b100;
        end else begin
            if (state == 3'b110) begin
                next_state = 3'b000;
            end else begin
                next_state = state + 1;
            end
        end
    end

    assign q = state;

endmodule
[DONE]