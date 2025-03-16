module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_counter;
    logic y_flag;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
            y_flag <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
            y_flag <= 1'b0;
            next_state <= STATE_B;
        end else if (current_state == STATE_B) begin
            f <= 1'b1;
            x_counter <= {x_counter[1:0], x}; // Shift in x
            if (x_counter == 3'b101) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_C) begin
            g <= 1'b1;
            y_flag <= 1'b0;
            next_state <= STATE_D;
        end else if (current_state == STATE_D) begin
            if (y_flag < 2) begin
                if (y) begin
                    y_flag <= 2'b10; // Set flag to maintain g
                end else begin
                    y_flag <= y_flag + 1;
                end
            end else begin
                g <= 1'b0;
                next_state <= STATE_A; // Go back to state A
            end
        end
    end

endmodule