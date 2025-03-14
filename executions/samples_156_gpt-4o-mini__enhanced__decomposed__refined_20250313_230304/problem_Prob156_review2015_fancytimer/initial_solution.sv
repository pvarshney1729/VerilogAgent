[BEGIN]
module TopModule (
    input logic clk,                // Clock signal (positive edge triggered)
    input logic reset,              // Synchronous active-high reset signal
    input logic data,               // Serial data input
    output logic [3:0] count,       // 4-bit output for current count value
    output logic counting,           // Output signal indicating counting (active high)
    output logic done,               // Output signal indicating timer has completed (active high)
    input logic ack                 // Input signal for acknowledgment (active high)
);

    logic [2:0] state;                  // State for the state machine
    logic [3:0] delay;                  // Delay value shifted in after detecting 1101
    logic [19:0] cycle_count;           // Counter for clock cycles
    logic [2:0] bit_count;              // Counter for the bits received (for 1101 detection)
    logic [3:0] shift_reg;              // Register for shifting in the 4 bits after 1101

    localparam IDLE = 3'b000, 
               DETECT = 3'b001, 
               SHIFT_DELAY = 3'b010, 
               COUNTING = 3'b011, 
               DONE = 3'b100;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            cycle_count <= 20'b0;
            bit_count <= 3'b000;
            delay <= 4'b0000;
            shift_reg <= 4'b0000;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0; // Reset done signal
                    counting <= 1'b0; // Not counting
                    if (data == 1'b1) begin
                        state <= DETECT; // Start detecting pattern
                    end
                end
                
                DETECT: begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the new bit
                    bit_count <= bit_count + 1;
                    if (bit_count == 3) begin
                        if (shift_reg == 4'b1101) begin
                            state <= SHIFT_DELAY; // Pattern detected
                            bit_count <= 0; // Reset bit counter
                        end else begin
                            bit_count <= 0; // Reset bit counter if not matching
                        end
                    end
                end
                
                SHIFT_DELAY: begin
                    delay <= {delay[2:0], data}; // Shift in the new bit for delay
                    bit_count <= bit_count + 1;
                    if (bit_count == 4) begin
                        state <= COUNTING; // Move to counting state
                        counting <= 1'b1; // Start counting
                        cycle_count <= 20'b0; // Reset cycle count
                    end
                end
                
                COUNTING: begin
                    if (cycle_count < (delay + 1) * 1000 - 1) begin
                        cycle_count <= cycle_count + 1;
                        if (cycle_count % 1000 == 0) begin
                            count <= count - 1; // Decrement count every 1000 cycles
                        end
                    end else begin
                        counting <= 1'b0; // Stop counting
                        done <= 1'b1; // Assert done signal
                        state <= DONE; // Move to done state
                    end
                end
                
                DONE: begin
                    if (ack) begin
                        done <= 1'b0; // Clear done signal on ack
                        state <= IDLE; // Reset to IDLE state
                    end
                end
            endcase
        end
    end
endmodule
[DONE]