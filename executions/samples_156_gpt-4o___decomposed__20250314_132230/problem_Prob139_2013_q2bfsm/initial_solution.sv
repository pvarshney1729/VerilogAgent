module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
    output logic f,
    output logic g
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A, // Initial state
        STATE_B, // Set f = 1 for one cycle
        STATE_C, // Monitor x for sequence 1
        STATE_D, // Monitor x for sequence 1, 0
        STATE_E, // Monitor x for sequence 1, 0, 1
        STATE_F, // Set g = 1 and monitor y
        STATE_G, // Maintain g = 1 permanently
        STATE_H  // Set g = 0 permanently
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;
    logic g_reg, g_permanent;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            g_reg <= 1'b0;
            g_permanent <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_F) begin
                g_reg <= 1'b1;
            end
            if (current_state == STATE_G) begin
                g_permanent <= 1'b1;
            end
        end
    end

    // Combinational block for state transition logic and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        f = 1'b0;
        g = g_reg && !g_permanent;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    f = 1'b1;
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (!x) begin
                    next_state = STATE_E;
                end
            end
            STATE_E: begin
                if (x) begin
                    next_state = STATE_F;
                end
            end
            STATE_F: begin
                if (y) begin
                    next_state = STATE_G;
                end else if (y_counter < 2) begin
                    y_counter = y_counter + 1;
                end else begin
                    next_state = STATE_H;
                end
            end
            STATE_G: begin
                g = 1'b1;
            end
            STATE_H: begin
                g = 1'b0;
            end
        endcase
    end

endmodule