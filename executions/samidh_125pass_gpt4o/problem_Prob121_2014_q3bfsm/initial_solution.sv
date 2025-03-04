module TopModule (
    input  logic clk,       // Clock signal, positive edge triggered
    input  logic reset,     // Synchronous active high reset
    input  logic x,         // Input signal
    output logic z          // Output signal, registered
);

    logic [2:0] y;          // State register

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
        end else begin
            case (y)
                3'b000: y <= (x) ? 3'b001 : 3'b000;
                3'b001: y <= (x) ? 3'b100 : 3'b001;
                3'b010: y <= (x) ? 3'b001 : 3'b010;
                3'b011: y <= (x) ? 3'b010 : 3'b001;
                3'b100: y <= (x) ? 3'b100 : 3'b011;
                default: y <= 3'b000; // Handle undefined states
            endcase
        end
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
        end else begin
            case (y)
                3'b011, 3'b100: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule