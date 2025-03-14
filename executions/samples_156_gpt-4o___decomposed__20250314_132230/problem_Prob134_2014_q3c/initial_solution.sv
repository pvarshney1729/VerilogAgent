module TopModule(
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] Y; // Register to hold the next state

    always @(posedge clk) begin
        case (y)
            3'b000: Y <= (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: Y <= (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: Y <= (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: Y <= (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: Y <= (x == 1'b0) ? 3'b011 : 3'b100;
            default: Y <= 3'b000; // Default case to handle any unexpected state
        endcase
    end

    always @(*) begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0; // Default to handle any unexpected state
        endcase
    end

    always @(*) begin
        Y0 = Y[0]; // Output Y0 is the least significant bit of the next state
    end
endmodule