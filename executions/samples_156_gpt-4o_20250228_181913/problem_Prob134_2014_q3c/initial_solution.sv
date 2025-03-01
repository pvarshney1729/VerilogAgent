module TopModule (
    input logic clk,
    input logic reset_n,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] Y; // Next state

    // State transition logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            Y <= 3'b000;
        end else begin
            case (y)
                3'b000: Y <= (x == 1'b0) ? 3'b000 : 3'b001;
                3'b001: Y <= (x == 1'b0) ? 3'b001 : 3'b100;
                3'b010: Y <= (x == 1'b0) ? 3'b010 : 3'b001;
                3'b011: Y <= (x == 1'b0) ? 3'b001 : 3'b010;
                3'b100: Y <= (x == 1'b0) ? 3'b011 : 3'b100;
                default: Y <= 3'b000; // Safe state for undefined states
            endcase
        end
    end

    // Output logic
    always_comb begin
        Y0 = Y[0];
        case (y)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0; // Safe output for undefined states
        endcase
    end

endmodule