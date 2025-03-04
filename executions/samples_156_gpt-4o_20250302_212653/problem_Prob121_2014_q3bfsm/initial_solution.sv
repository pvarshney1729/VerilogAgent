module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic reset,       // Synchronous active high reset
    input logic x,           // Input signal x
    output logic z           // Output signal z
);

    logic [2:0] y;           // State register, 3 bits wide

    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
            z <= 1'b0;
        end else begin
            case (y)
                3'b000: begin
                    y <= (x ? 3'b001 : 3'b000);
                    z <= 1'b0;
                end
                3'b001: begin
                    y <= (x ? 3'b100 : 3'b001);
                    z <= 1'b0;
                end
                3'b010: begin
                    y <= (x ? 3'b001 : 3'b010);
                    z <= 1'b0;
                end
                3'b011: begin
                    y <= (x ? 3'b010 : 3'b001);
                    z <= 1'b1;
                end
                3'b100: begin
                    y <= (x ? 3'b100 : 3'b011);
                    z <= 1'b1;
                end
                default: begin
                    y <= 3'b000; // Default state on unexpected state
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule