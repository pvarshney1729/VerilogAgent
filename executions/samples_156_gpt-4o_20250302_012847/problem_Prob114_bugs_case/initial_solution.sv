module scancode_mapper (
    input logic [7:0] scancode,
    output logic [3:0] mapped_code
);

    always @(*) begin
        case (scancode)
            8'h1C: mapped_code = 4'h1; // Example mapping
            8'h32: mapped_code = 4'h2; // Example mapping
            8'h21: mapped_code = 4'h3; // Example mapping
            8'h23: mapped_code = 4'h4; // Example mapping
            8'h24: mapped_code = 4'h5; // Example mapping
            8'h2B: mapped_code = 4'h6; // Example mapping
            8'h34: mapped_code = 4'h7; // Example mapping
            8'h33: mapped_code = 4'h8; // Example mapping
            8'h43: mapped_code = 4'h9; // Example mapping
            8'h3B: mapped_code = 4'hA; // Example mapping
            8'h42: mapped_code = 4'hB; // Example mapping
            8'h4B: mapped_code = 4'hC; // Example mapping
            8'h3A: mapped_code = 4'hD; // Example mapping
            8'h31: mapped_code = 4'hE; // Example mapping
            8'h44: mapped_code = 4'hF; // Example mapping
            default: mapped_code = 4'h0; // Default mapping
        endcase
    end

endmodule