module TopModule(
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic [2:0] y, next_y;

    // State Transition Logic
    always @(*) begin
        case (y)
            3'b000: next_y = (x) ? 3'b001 : 3'b000;
            3'b001: next_y = (x) ? 3'b100 : 3'b001;
            3'b010: next_y = (x) ? 3'b001 : 3'b010;
            3'b011: next_y = (x) ? 3'b010 : 3'b001;
            3'b100: next_y = (x) ? 3'b100 : 3'b011;
            default: next_y = 3'b000; // Handle invalid states
        endcase
    end

    // Output Logic
    always @(*) begin
        case (y)
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State Register
    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
            z <= 1'b0;
        end else begin
            y <= next_y;
        end
    end

endmodule