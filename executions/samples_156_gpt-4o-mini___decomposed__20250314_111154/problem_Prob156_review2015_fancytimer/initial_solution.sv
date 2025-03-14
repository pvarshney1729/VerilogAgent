module TopModule(
    input clk,
    input reset,
    input data,
    input ack,
    output reg [3:0] count,
    output reg counting,
    output reg done
);
    reg [3:0] delay;
    reg [19:0] cycle_count;
    reg [2:0] state;
    reg [3:0] remaining_time;
    reg [3:0] bit_counter;
    reg [2:0] pattern_counter;

    localparam IDLE = 3'b000,
               DETECT = 3'b001,
               SHIFT_DELAY = 3'b010,
               COUNTING = 3'b011,
               DONE = 3'b100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'bxxxx; // Don't care
            counting <= 0;
            done <= 0;
            cycle_count <= 0;
            delay <= 0;
            remaining_time <= 0;
            bit_counter <= 0;
            pattern_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    pattern_counter <= 0;
                    if (data) begin
                        pattern_counter <= pattern_counter + 1;
                        if (pattern_counter == 3) begin
                            state <= SHIFT_DELAY;
                            pattern_counter <= 0; // Reset for the next detection
                        end
                    end
                end
                
                SHIFT_DELAY: begin
                    if (bit_counter < 4) begin
                        delay[3-bit_counter] <= data; // Shift in the next 4 bits
                        bit_counter <= bit_counter + 1;
                    end else begin
                        remaining_time <= delay + 4'b0001; // Delay + 1
                        count <= remaining_time;
                        counting <= 1;
                        cycle_count <= 0; // Reset cycle count
                        state <= COUNTING;
                        bit_counter <= 0;
                    end
                end
                
                COUNTING: begin
                    if (cycle_count < (remaining_time * 1000)) begin
                        cycle_count <= cycle_count + 1;
                        if (cycle_count % 1000 == 0) begin
                            count <= remaining_time > 0 ? remaining_time - 1 : 0;
                            remaining_time <= remaining_time > 0 ? remaining_time - 1 : 0;
                        end
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= DONE;
                    end
                end
                
                DONE: begin
                    count <= 4'bxxxx; // Don't care when done
                    if (ack) begin
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly