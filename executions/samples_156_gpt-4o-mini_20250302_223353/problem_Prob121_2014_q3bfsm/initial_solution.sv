module TopModule (
    input logic clk,         // Positive edge-triggered clock signal
    input logic reset,       // Synchronous active-high reset signal
    input logic x,           // Input signal
    output logic z           // Output signal
);
    logic [2:0] y;          // 3-bit state register

    // Synchronous reset and state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;     // Reset state
            z <= 1'b0;       // Reset output
        end else begin
            case (y)
                3'b000: begin
                    if (x) begin
                        y <= 3'b001;
                    end else begin
                        y <= 3'b000;
                    end
                    z <= 1'b0;
                end
                3'b001: begin
                    if (x) begin
                        y <= 3'b100;
                    end else begin
                        y <= 3'b001;
                    end
                    z <= 1'b0;
                end
                3'b010: begin
                    if (x) begin
                        y <= 3'b001;
                    end else begin
                        y <= 3'b010;
                    end
                    z <= 1'b0;
                end
                3'b011: begin
                    if (x) begin
                        y <= 3'b010;
                        z <= 1'b1;
                    end else begin
                        y <= 3'b001;
                        z <= 1'b1;
                    end
                end
                3'b100: begin
                    if (x) begin
                        y <= 3'b100;
                    end else begin
                        y <= 3'b011;
                    end
                    z <= 1'b1;
                end
                default: begin
                    y <= 3'b000; // Default to state 000 on invalid state
                    z <= 1'b0;
                end
            endcase
        end
    end
endmodule