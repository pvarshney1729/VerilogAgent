module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic x,
    output logic z
);

    // State declaration
    logic [2:0] y; // Current state

    // Next state and output logic
    always @(*) begin
        case (y)
            3'b000: begin
                if (x) begin
                    z = 0;
                    y_next = 3'b001;
                end else begin
                    z = 0;
                    y_next = 3'b000;
                end
            end
            
            3'b001: begin
                if (x) begin
                    z = 0;
                    y_next = 3'b100;
                end else begin
                    z = 0;
                    y_next = 3'b001;
                end
            end
            
            3'b010: begin
                if (x) begin
                    z = 0;
                    y_next = 3'b001;
                end else begin
                    z = 0;
                    y_next = 3'b010;
                end
            end
            
            3'b011: begin
                z = 1;
                if (x) begin
                    y_next = 3'b010;
                end else begin
                    y_next = 3'b001;
                end
            end
            
            3'b100: begin
                z = 1;
                if (x) begin
                    y_next = 3'b100;
                end else begin
                    y_next = 3'b011;
                end
            end
            
            default: begin
                z = 0;
                y_next = 3'b000; // Safe default
            end
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000; // Synchronous reset
        end else begin
            y <= y_next; // Update state
        end
    end

endmodule