module TopModule (
    input logic clk,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    // Combinational logic to calculate next state
    always @(*) begin
        integer i, j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer count;
                count = 0;

                // Count neighbors with toroidal wrapping
                count = q[((i-1+16)%16)*16 + ((j-1+16)%16)] + q[((i-1+16)%16)*16 + j] + q[((i-1+16)%16)*16 + ((j+1)%16)] +
                        q[i*16 + ((j-1+16)%16)] + q[i*16 + ((j+1)%16)] +
                        q[((i+1)%16)*16 + ((j-1+16)%16)] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + ((j+1)%16)];

                // Game of Life rules
                if (count == 3 || (count == 2 && q[i*16 + j]))
                    next_q[i*16 + j] = 1;
                else
                    next_q[i*16 + j] = 0;
            end
        end
    end

    // Sequential logic to update state
    always_ff @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule