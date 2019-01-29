#include<iostream>
#include"Graph.h"
#include"Graphmatrix.h"
#include <fstream>
#include <regex>
#include <string>
#include <vector>
#include <iomanip>
using namespace std;

template<typename Tv, typename Te>
void DisplayMatrix(GraphMatrix<Tv, Te>* graph)
{
	cout << "\t";
	for (int i = 0; i < graph->Graph<Tv, Te>::n; i++)
	{
		cout << graph->vertex(i) << "\t";
	}
	cout << endl;
	for (int i = 0; i < graph->Graph<Tv, Te>::n; i++)
	{
		cout << graph->vertex(i) << "\t";
		for (int j = 0; j < graph->Graph<Tv, Te>::n; j++)
		{
			if (graph->exists(i, j))
			{
				cout << graph->weight(i, j);
			}
			else
			{
				cout << 0;
			}
			cout << "\t";
		}
		cout << endl;
	}
}

int main()
{
	vector<double> temp_line;
	vector<vector<double>> Vec_Dti;
	string line;
	ifstream in("Network.txt");  	
	regex pat_regex("[[:digit:]][[:digit:]][[:punct:]][[:digit:]]");	
	while (getline(in, line)) 
	{ 
		for (sregex_iterator it(line.begin(), line.end(), pat_regex), end_it; it != end_it; ++it) 
		{  
			cout << it->str() << " ";  
			temp_line.push_back(stod(it->str()));  
		}
		cout << endl;
		Vec_Dti.push_back(temp_line); 
		temp_line.clear();
	}
	cout << endl << endl;
	GraphMatrix<int, double> Network;  
	for (int i = 1; i <= 32; i++)
	{
		Network.insert(i);
	}
	for (int i = 0; i < 32; i++) {  
		for (int j = i; j < 32; j++) {
			Vec_Dti[i][j] = Vec_Dti[j][i];
		}
	}
	for (int i = 0; i < 32; i++) {
		for (int j = 0; j < 32; j++) {
			if ((int)Vec_Dti[i][j] != 0)
				Network.insert(0, Vec_Dti[i][j], i, j);
		}
	}
	cout << endl;
	DisplayMatrix(&Network);  
	cout << endl;
	double shortest[32][32] = { 0 };
	cout << "min_len";
	for (int i = 0; i < 32; i++)
	{
		Network.dijkstra(i);
		cout << i << ":\n";
		for (int j = 0; j < Network.Graph<int, double>::n; j++)
		{
			shortest[i][j] = Network.priority(j);
			cout << "\t" << Network.priority(j); 
			if (j % 10 == 9)
				cout << endl;
		}
		cout << endl;
	}
	cout << endl;
	ofstream mycout("temp.txt");
	for (int i = 0; i < 32; i++)
	{
		for (int j = 0; j < Network.Graph<int, double>::n; j++)
		{
			cout << setw(5) << left << shortest[i][j];
			mycout << shortest[i][j] << '\t';
		}
		cout << endl;
		mycout << endl;
	}
	cout << endl;
	mycout.close();
	return 0;
}