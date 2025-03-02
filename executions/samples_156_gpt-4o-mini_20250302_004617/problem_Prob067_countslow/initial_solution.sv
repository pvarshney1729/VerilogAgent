module decade_counter (
    input logic clk,
    input logic reset,
    input logic slowena,
    output logic [3:0] count
);
    logic [3:0] next_count;

    always @(*) begin
        if (reset) begin
            next_count = 4'b0000;
        end else if (slowena) begin
            if (count == 4'b1001) begin
                next_count = 4'b0000;
            end else begin
                next_count = count + 4'b0001;
            end
        end else begin
            next_count = count;
        end
    end

    always @(posedge clk) begin
        count <= next_count;
    end

    initial begin
        count = 4'b0000;
    end
endmodule