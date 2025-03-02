module TopModule (
    input logic [5:0] data_in,  // 6-bit input data
    input logic [2:0] sel,      // 3-bit select signal
    input logic clk,            // Clock signal
    input logic rst_n,          // Active low synchronous reset
    output logic data_out       // Output data
);

    always @(posedge clk) begin
        if (!rst_n) begin
            data_out <= 1'b0;    // Initialize output to zero on reset
        end else begin
            case (sel)
                3'b000: data_out <= data_in[0]; // Select input 0
                3'b001: data_out <= data_in[1]; // Select input 1
                3'b010: data_out <= data_in[2]; // Select input 2
                3'b011: data_out <= data_in[3]; // Select input 3
                3'b100: data_out <= data_in[4]; // Select input 4
                3'b101: data_out <= data_in[5]; // Select input 5
                default: data_out <= 1'b0;       // Default case
            endcase
        end
    end

endmodule