[BEGIN]
```verilog
module TopModule (
    input  logic clk,             
    input  logic areset,          
    input  logic train_valid,     
    input  logic train_taken,     
    output logic [1:0] state      
);
    logic [1:0] counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            counter <= 2'b01;
        end else if (train_valid) begin
            if (train_taken) begin
                counter <= (counter < 2'b11) ? (counter + 1) : counter; // Increment with saturation
            end else begin
                counter <= (counter > 2'b00) ? (counter - 1) : counter; // Decrement with saturation
            end
        end
    end

    assign state = counter;
endmodule
```
[DONE]