module mult3x3(p0,p1,p2,p3,p4,p5,a0,a1,a2,b0,b1,b2);

	output p0,p1,p2,p3,p4,p5;
	input a0,a1,a2,b0,b1,b2;

	// It is P0
	wire a0_nand_b0;
	nand(a0_nand_b0, a0, b0);
	not(p0, a0_nand_b0);
	
	// It is P1
	wire a1_nand_b0;
	wire a0_nand_b1;
	wire a1_nand_b0_not;
	wire a0_nand_b1_not;
	wire a1b0_a0b1;
	wire part1_of_sum_p1;
	wire part2_of_sum_p1;
	wire carry1;

	nand(a1_nand_b0, a1, b0);
	not(a1_nand_b0_not, a1_nand_b0);
	nand(a0_nand_b1, a0, b1);
	not(a0_nand_b1_not, a0_nand_b1);

	nand(a1b0_a0b1, a1_nand_b0_not, a0_nand_b1_not);
	not(carry1, a1b0_a0b1);
	nand(part1_of_sum_p1, a1_nand_b0_not, a1b0_a0b1);
	nand(part2_of_sum_p1, a0_nand_b1_not, a1b0_a0b1);
	nand(p1, part1_of_sum_p1, part2_of_sum_p1);
	
	// It is P2 
	wire a2_nand_b0;
	wire a1_nand_b1;
	wire a0_nand_b2;
	wire a2_nand_b0_not;
	wire a1_nand_b1_not;
	wire a0_nand_b2_not;
	wire a2b0_a1b1;
	wire part1_of_sum_p2;
	wire part2_of_sum_p2;
	wire sum_of_a2b0_a1b1;
	wire carry2;
	wire cin_p3;

	nand(a2_nand_b0, a2, b0);
	not(a2_nand_b0_not, a2_nand_b0);
	nand(a1_nand_b1, a1, b1);
	not(a1_nand_b1_not, a1_nand_b1);
	nand(a0_nand_b2, a0, b2);
	not(a0_nand_b2_not, a0_nand_b2);

	nand(a2b0_a1b1, a2_nand_b0_not, a1_nand_b1_not);
	not(carry2, a2b0_a1b1);

	nand(part1_of_sum_p2, a2_nand_b0_not, a2b0_a1b1);
	nand(part2_of_sum_p2, a1_nand_b1_not, a2b0_a1b1);
	nand(sum_of_a2b0_a1b1, part1_of_sum_p2, part2_of_sum_p2);

	wire sum_nand_a0b2; // carry
	nand(sum_nand_a0b2, sum_of_a2b0_a1b1, a0_nand_b2_not);
	wire sum_of_sum_nand_a0b2_prt1;
	wire sum_of_sum_nand_a0b2_prt2;

	nand(sum_of_sum_nand_a0b2_prt1, sum_of_a2b0_a1b1, sum_nand_a0b2);
	nand(sum_of_sum_nand_a0b2_prt2, a0_nand_b2_not, sum_nand_a0b2);
	wire final_sum_p2;
	nand(final_sum_p2,sum_of_sum_nand_a0b2_prt1,sum_of_sum_nand_a0b2_prt2);

	wire nand_carry1_final_sum_p2; // carry
	nand(nand_carry1_final_sum_p2, carry1, final_sum_p2);
	nand(cin_p3, sum_nand_a0b2, nand_carry1_final_sum_p2); // Cin of P3
	
	wire prt1_p2;
	wire prt2_p2;
	nand(prt1_p2, final_sum_p2, nand_carry1_final_sum_p2);
	nand(prt2_p2, carry1, nand_carry1_final_sum_p2);
	nand(p2, prt1_p2, prt2_p2);
	
	//It is P3
	wire a2_nand_b1;
	wire a1_nand_b2;
	wire a2_nand_b1_not;
	wire a1_nand_b2_not;
	wire a2b1_a1b2;	
	wire part1_of_sum_p3;
	wire part2_of_sum_p3;
	wire sum_of_a2b1_a1b2;
	wire cin_p4;

	nand(a2_nand_b1, a2, b1);
	not(a2_nand_b1_not, a2_nand_b1);
	nand(a1_nand_b2, a1, b2);
	not(a1_nand_b2_not, a1_nand_b2);

	nand(a2b1_a1b2, a2_nand_b1_not, a1_nand_b2_not); // a2b1_a1b2 = carry 3


	nand(part1_of_sum_p3, a2_nand_b1_not, a2b1_a1b2);
	nand(part2_of_sum_p3, a1_nand_b2_not, a2b1_a1b2);
	nand(sum_of_a2b1_a1b2, part1_of_sum_p3, part2_of_sum_p3);

	wire nand_carry2_sum_a2b1_a1b2;
	nand(nand_carry2_sum_a2b1_a1b2, carry2, sum_of_a2b1_a1b2);
	nand(cin_p4, a2b1_a1b2, nand_carry2_sum_a2b1_a1b2); // Cin of P4

	wire prt1_sum_a2b1_a1b2_fi;
	wire prt2_sum_a2b1_a1b2_fi;
	nand(prt1_sum_a2b1_a1b2_fi, nand_carry2_sum_a2b1_a1b2, sum_of_a2b1_a1b2);
	nand(prt2_sum_a2b1_a1b2_fi, nand_carry2_sum_a2b1_a1b2, carry2);
	wire fi_sum_p3;
	nand(fi_sum_p3, prt1_sum_a2b1_a1b2_fi, prt2_sum_a2b1_a1b2_fi);

	wire fi_sum_cin_p3;
	nand(fi_sum_cin_p3, fi_sum_p3, cin_p3);
	wire cout_p3;
	not(cout_p3, fi_sum_cin_p3); // Cout of P3

	wire prt1_p3;
	wire prt2_p3;
	nand(prt1_p3, cin_p3, fi_sum_cin_p3);
	nand(prt2_p3, fi_sum_p3, fi_sum_cin_p3);
	nand(p3, prt1_p3, prt2_p3);

	// It is P4
	wire a2_nand_b2;
	wire a2_nand_b2_not;
	wire nand_cin_a2b2;

	nand(a2_nand_b2, a2 , b2);
	not(a2_nand_b2_not, a2_nand_b2);

	nand(nand_cin_a2b2, cin_p4, a2_nand_b2_not); // part of Cout P4

	wire prt1_sum_cin_a2b2;
	wire prt2_sum_cin_a2b2;

	nand(prt1_sum_cin_a2b2, cin_p4, nand_cin_a2b2);
	nand(prt2_sum_cin_a2b2, a2_nand_b2_not, nand_cin_a2b2);
	
	wire sum_p4;
	nand(sum_p4, prt1_sum_cin_a2b2, prt2_sum_cin_a2b2);

	wire nand_coutP3_sum_p4;
	nand(nand_coutP3_sum_p4, sum_p4, cout_p3);
	wire prt1_final_sum_p4;
	wire prt2_final_sum_p4;

	nand(prt1_final_sum_p4, sum_p4, nand_coutP3_sum_p4);
	nand(prt2_final_sum_p4, cout_p3, nand_coutP3_sum_p4);

	nand(p4, prt1_final_sum_p4, prt2_final_sum_p4);

	// It is P5
	nand(p5, nand_cin_a2b2, nand_coutP3_sum_p4);
	

endmodule