module TopModule (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [7:0] result
);

    logic [7:0] data;
    logic [3:0] state;
    logic [3:0] next_state;

    // State encoding
    localparam IDLE = 4'b0000;
    localparam READ = 4'b0001;
    localparam COMPUTE = 4'b0010;
    localparam OUTPUT = 4'b0011;

    // Synchronous reset and state transition
    always @(*) begin
        case (state)
            IDLE: next_state = (serial_in) ? READ : IDLE;
            READ: next_state = (data[7] == 1'b1) ? COMPUTE : READ;
            COMPUTE: next_state = OUTPUT;
            OUTPUT: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
            data <= 8'b00000000;
        end else begin
            state <= next_state;
            if (state == READ) begin
                data <= {data[6:0], serial_in}; // Shift in serial data
            end else if (state == COMPUTE) begin
                data <= ~data + 1'b1; // Compute 2's complement
            end
        end
    end

    assign result = (state == OUTPUT) ? data : 8'b00000000;

endmodule