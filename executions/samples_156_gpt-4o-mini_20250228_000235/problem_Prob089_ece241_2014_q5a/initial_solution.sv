module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE,
        ADD_ONE,
        OUTPUT
    } state_t;

    state_t current_state, next_state;
    logic [1:0] count; // To count the number of bits processed
    logic [1:0] twos_complement; // To hold the 2's complement result

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            count <= 2'b00;
            twos_complement <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (!areset) begin
            case (current_state)
                IDLE: begin
                    if (count < 2'b11) begin
                        next_state <= ADD_ONE;
                    end else begin
                        next_state <= OUTPUT;
                    end
                end
                ADD_ONE: begin
                    twos_complement <= twos_complement + 1;
                    count <= count + 1;
                    next_state <= IDLE;
                end
                OUTPUT: begin
                    z <= twos_complement[0]; // Output the least significant bit
                    next_state <= IDLE; // Go back to IDLE
                end
            endcase
        end
    end

    assign z = (current_state == OUTPUT) ? twos_complement[0] : 1'b0;

endmodule