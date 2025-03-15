module decade_counter (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

    logic [3:0] next_count;

    always @(*) begin
        if (count == 4'b1001) 
            next_count = 4'b0000; 
        else 
            next_count = count + 4'b0001; 
    end

    always @(posedge clk) begin
        if (reset) 
            count <= 4'b0000; 
        else 
            count <= next_count; 
    end

    initial begin
        count = 4'b0000;
    end

endmodule