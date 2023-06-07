`include "mult3x3.v"

module tb_mult3x3();
	
	reg a0,b0,a1,b1,a2,b2;
	wire p0,p1,p2,p3,p4,p5;

	mult3x3 mult3x3_1(p0,p1,p2,p3,p4,p5,a0,a1,a2,b0,b1,b2);

	initial begin 
		a0 = 0;
		a1 = 0;
		a2 = 0;
		b0 = 0;
		b1 = 0;
		b2 = 0;

		#50;

		a0 = 1;
		a1 = 1;
		a2 = 0;
		b0 = 1;
		b1 = 0;
		b2 = 1;

		#50;

		a0 = 0;
		a1 = 1;
		a2 = 1;
		b0 = 1;
		b1 = 0;
		b2 = 0;

		#50;

		a0 = 0;
		a1 = 1;
		a2 = 0;
		b0 = 1;
		b1 = 1;
		b2 = 1;

		#50;

		a0 = 1;
		a1 = 1;
		a2 = 1;
		b0 = 1;
		b1 = 1;
		b2 = 0;

		#50;

		a0 = 0;
		a1 = 0;
		a2 = 1;
		b0 = 0;
		b1 = 0;
		b2 = 1;

		#50;
	
		
	end
endmodule