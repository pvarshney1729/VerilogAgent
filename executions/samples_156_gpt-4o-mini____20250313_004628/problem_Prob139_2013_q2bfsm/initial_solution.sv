module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
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
    logic [2:0] x_count;
    logic y_flag;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_count <= 3'b000;
            y_flag <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_B) begin
            if (x_count < 3'b011) begin
                x_count <= x_count + 1'b1;
            end else begin
                x_count <= 3'b000;
                next_state <= STATE_C;
            end
        end else if (current_state == STATE_C) begin
            if (y_flag) begin
                g <= 1'b1;
            end else begin
                g <= 1'b0;
            end
        end else if (current_state == STATE_D) begin
            if (y_flag) begin
                g <= 1'b1;
            end else begin
                g <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A && !resetn) begin
            next_state <= STATE_B;
            x_count <= 3'b000;
            y_flag <= 1'b0;
        end else if (current_state == STATE_B) begin
            if (x == 1'b1) begin
                x_count <= x_count + 1'b1;
            end else begin
                x_count <= 3'b000;
            end
        end else if (current_state == STATE_C) begin
            if (y == 1'b1) begin
                y_flag <= 1'b1;
                next_state <= STATE_D;
            end else begin
                y_flag <= 1'b0;
                next_state <= STATE_D;
            end
        end else if (current_state == STATE_D) begin
            if (y == 1'b1) begin
                y_flag <= 1'b1;
            end else begin
                y_flag <= 1'b0;
            end
        end
    end

endmodule