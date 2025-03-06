module TopModule (
    input logic clk,         
    input logic areset,      
    input logic bump_left,   
    input logic bump_right,  
    input logic ground,      
    input logic dig,         
    output logic walk_left,   
    output logic walk_right,  
    output logic aaah,        
    output logic digging      
);

    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else if (dig && ground) 
                    next_state = DIG_LEFT;
                else if (bump_left) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = WALK_LEFT;
            end
            
            WALK_RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else if (dig && ground) 
                    next_state = DIG_RIGHT;
                else if (bump_right) 
                    next_state = WALK_LEFT;
                else 
                    next_state = WALK_RIGHT;
            end
            
            FALL_LEFT: begin
                if (ground) 
                    next_state = WALK_LEFT;
                else 
                    next_state = FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                if (ground) 
                    next_state = WALK_RIGHT;
                else 
                    next_state = FALL_RIGHT;
            end
            
            DIG_LEFT: begin
                if (!ground) 
                    next_state = FALL_LEFT;
                else 
                    next_state = DIG_LEFT;
            end
            
            DIG_RIGHT: begin
                if (!ground) 
                    next_state = FALL_RIGHT;
                else 
                    next_state = DIG_RIGHT;
            end
            
            default: next_state = WALK_LEFT; // Safe state
        endcase
    end

    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
            end
            
            WALK_RIGHT: begin
                walk_right = 1;
            end
            
            FALL_LEFT: begin
                aaah = 1;
            end
            
            FALL_RIGHT: begin
                aaah = 1;
            end
            
            DIG_LEFT: begin
                walk_left = 1;
                digging = 1;
            end
            
            DIG_RIGHT: begin
                walk_right = 1;
                digging = 1;
            end
        endcase
    end
endmodule