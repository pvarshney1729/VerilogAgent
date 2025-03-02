```verilog
module BitProcessor (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] result
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        READ = 2'b01,
        PROCESS = 2'b10,
        OUTPUT = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data_reg;
    logic [2:0] bit_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            data_reg <= 8'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            if (current_state == READ) begin
                data_reg <= {data_reg[6:0], serial_in};
                bit_count <= bit_count + 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (!reset) next_state = READ;
                else next_state = IDLE;
            end
            READ: begin
                if (bit_count == 3'b111) next_state = PROCESS;
                else next_state = READ;
            end
            PROCESS: begin
                next_state = OUTPUT;
            end
            OUTPUT: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (current_state == PROCESS) begin
            result <= ~data_reg + 1; // 2's complement operation
        end
    end

endmodule
```