module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= 3'b000;
        end else begin
            case (y)
                3'b000: begin
                    if (x) next_state <= 3'b001;
                    else next_state <= 3'b000;
                    z <= 1'b0;
                end
                3'b001: begin
                    if (x) next_state <= 3'b100;
                    else next_state <= 3'b001;
                    z <= 1'b0;
                end
                3'b010: begin
                    if (x) next_state <= 3'b001;
                    else next_state <= 3'b010;
                    z <= 1'b0;
                end
                3'b011: begin
                    if (x) next_state <= 3'b010;
                    else next_state <= 3'b001;
                    z <= 1'b1;
                end
                3'b100: begin
                    if (x) next_state <= 3'b100;
                    else next_state <= 3'b011;
                    z <= 1'b1;
                end
                default: begin
                    next_state <= 3'b000;
                    z <= 1'b0;
                end
            endcase
        end
    end

    assign Y0 = next_state[0];

endmodule