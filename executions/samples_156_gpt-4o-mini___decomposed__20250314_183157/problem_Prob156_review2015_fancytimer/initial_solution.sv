module TopModule (
    input clk,
    input reset,
    input data,
    input ack,
    output reg [3:0] count,
    output reg counting,
    output reg done
);

    reg [3:0] delay;
    reg [9:0] counter; // To count for (delay + 1) * 1000 cycles
    reg [2:0] state; // State for the state machine

    localparam IDLE = 3'b000,
               DETECT = 3'b001,
               SHIFT = 3'b010,
               COUNT = 3'b011,
               DONE = 3'b100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'bxxxx; // don't care
            delay <= 4'b0000;
            counter <= 10'b0;
        end else begin
            case (state)
                IDLE: begin
                    if ({data, data, data, data} == 4'b1101) begin
                        state <= SHIFT;
                        delay <= 4'b0000; // Reset delay for shifting
                    end
                end
                SHIFT: begin
                    delay <= {data, delay[3:1]}; // Shift in the next bit
                    if (delay[3] !== 1'bx) begin
                        state <= COUNT;
                        counting <= 1'b1;
                        counter <= 10'b0; // Initialize counter
                    end
                end
                COUNT: begin
                    if (counter < (delay + 1) * 1000 - 1) begin
                        counter <= counter + 1;
                        if (counter % 1000 == 0) begin
                            count <= (delay > 0) ? delay : 4'b0000; // Output current remaining time
                            if (delay > 0) delay <= delay - 1; // Decrement delay
                        end
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        state <= DONE;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly