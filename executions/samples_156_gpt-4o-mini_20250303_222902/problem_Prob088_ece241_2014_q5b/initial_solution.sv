module TopModule (
    input  logic clk,        // Clock signal, triggers on positive edge
    input  logic areset,     // Asynchronous active-high reset
    input  logic x,          // Input signal
    output logic z           // Output signal
);

    logic [1:0] state;  // One-hot encoded state register

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;  // State A
            z <= 0;
        end
        else begin
            case (state)
                2'b01: begin  // State A
                    if (x) begin
                        state <= 2'b10;  // Transition to State B
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                end
                2'b10: begin  // State B
                    if (x) begin
                        z <= 0;
                    end
                    else begin
                        z <= 1;
                    end
                end
                default: begin // Default case to handle unexpected states
                    state <= 2'b01;  // Reset to State A for safety
                    z <= 0;
                end
            endcase
        end
    end
endmodule