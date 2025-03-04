module TopModule (
    input wire clk,            // Clock input, positive edge triggered.
    input wire areset,         // Asynchronous active-high reset.
    input wire x,              // Input signal.
    output reg z               // Output signal.
);

    reg [1:0] state;           // One-hot encoded state register

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;    // Reset to state A
            z <= 0;
        end else begin
            case (state)
                2'b01: begin // State A
                    if (x) begin
                        state <= 2'b10; // Transition to State B
                        z <= 1;
                    end else begin
                        z <= 0; // Remain in State A
                    end
                end
                2'b10: begin // State B
                    if (x) begin
                        z <= 0; // Remain in State B
                    end else begin
                        z <= 1; // Remain in State B
                    end
                end
            endcase
        end
    end

endmodule