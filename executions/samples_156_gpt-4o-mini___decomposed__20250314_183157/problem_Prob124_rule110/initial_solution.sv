module TopModule (
    input logic clk,
    input logic load,
    input logic [511:0] data,
    output logic [511:0] q
);

    logic [511:0] current_state, next_state;

    always @(posedge clk) begin
        if (load) begin
            current_state <= data;
        end else begin
            current_state[0] <= 1'b0; // Boundary condition
            current_state[511] <= 1'b0; // Boundary condition
            for (integer i = 1; i < 511; i = i + 1) begin
                case ({current_state[i+1], current_state[i], current_state[i-1]})
                    3'b111: next_state[i] = 1'b0;
                    3'b110: next_state[i] = 1'b1;
                    3'b101: next_state[i] = 1'b1;
                    3'b100: next_state[i] = 1'b0;
                    3'b011: next_state[i] = 1'b1;
                    3'b010: next_state[i] = 1'b1;
                    3'b001: next_state[i] = 1'b1;
                    3'b000: next_state[i] = 1'b0;
                endcase
            end
            current_state <= next_state;
        end
    end

    assign q = current_state;

endmodule