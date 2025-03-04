module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    input logic reset,
    output logic Q
);

    logic Qold;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            Q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: Q <= Q;        // Hold state
                2'b01: Q <= 1'b0;     // Reset state
                2'b10: Q <= 1'b1;     // Set state
                2'b11: Q <= ~Q;       // Toggle state
            endcase
        end
    end

    always_ff @(posedge clk) begin
        Qold <= Q; // Store the previous state
    end

endmodule