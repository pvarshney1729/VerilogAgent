module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] scancode,
    output logic [7:0] out,
    output logic valid
);

    always @(*) begin
        valid = 1'b0; // Default valid to low
        out = 8'b00000000; // Default output to zero

        case (scancode)
            8'h1C: begin // 'A' key
                out = 8'h41; // ASCII for 'A'
                valid = 1'b1;
            end
            8'h32: begin // 'B' key
                out = 8'h42; // ASCII for 'B'
                valid = 1'b1;
            end
            8'h21: begin // 'C' key
                out = 8'h43; // ASCII for 'C'
                valid = 1'b1;
            end
            // Add more cases as needed for other keys
            default: begin
                out = 8'b00000000; // No valid key pressed
                valid = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            out <= 8'b00000000; // Reset output
            valid <= 1'b0; // Reset valid signal
        end
    end

endmodule