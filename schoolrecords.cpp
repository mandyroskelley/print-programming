#include <bits/stdc++.h>
#include <iostream>
#include <string>
using namespace std;

struct Node {
	int id;
	string name, gradeTitle, majorDept;
	bool isStudent;
	Node *next;
};
Node* head = NULL;

class Person {
	public:
		string name;
		int id = 0;
		bool idUnique = true;
	public:
		Person(){};
		virtual ~Person(){};
		bool setPerson(){
			cout << "Enter Name:\n";
			cin.get();
			getline(std::cin, name);
			cout << "Enter Id Number:\n";
			cin >> id;
			idUnique = checkId(id);

			return idUnique;
		};
		virtual void printAbout(struct Node* current){
			cout << "Name: " << current->name;
			cout << " ; Id: " << current->id;
		};

		bool checkId(int id){
			struct Node* current = head;
			idUnique = true;
				while (current != NULL) {
					if (current->id == id)
					{
						printf("ID already exists.\n");
						idUnique = false;
					}
					current = current->next;
				}
				return idUnique;
		}
};

class Student: public Person {
	public:
		string grade, major;
	public:
		Student(){};
		~Student(){};
		void setStudent(){
			idUnique = setPerson();
			if (idUnique == true) {
				cout << "Enter Average Grade of Student:\n";
				cin.get();
				getline(std::cin, grade);
				cout << "Enter Major of Student:\n";
				getline(std::cin, major);

				struct Node* newNode = (struct Node*) malloc(sizeof(struct Node));
				newNode->name = name;
				newNode->id = id;
				newNode->gradeTitle = grade;
				newNode->majorDept = major;
				newNode->isStudent = true;

				if (head != NULL){
				newNode->next = head;
				head = newNode;
				}
				else{
					head = newNode;
				};
			}
		};
		void printAbout(struct Node* current){
			Person p;
			p.printAbout(current);
			cout << " ; Major: " << current->majorDept;
			cout << " ; Average Grade: " << current->gradeTitle << endl;
		};
};

class Teacher: public Person {
	public:
		int num = 0;
		string title, dept;

	public:
		Teacher(){};
		~Teacher(){};
		void setTeacher(){
			idUnique = setPerson();
			if (idUnique == true) {
				cout << "Enter Title of Teacher: 1 if lecturer ; "
					"2 if assistant professor ; 3 if associate professor.\n";
				cin >> num;
				if (num == 1) {
					title = "lecturer";
				}
				else if (num == 2) {
					title = "assistant professor";
				}
				else if (num ==3){
					title = "associate professor";
				}
				else {
					title = "not specified";
				}
				cout << "Enter Teacher Department:\n";
				cin.get();
				getline(std::cin, dept);

				struct Node* newNode = new Node();
				newNode->name = name;
				newNode->id = id;
				newNode->gradeTitle = title;
				newNode->majorDept = dept;
				newNode->isStudent = false;

				if (head != NULL) {
					newNode->next = head;
					head = newNode;
				}
				else {
					head = newNode;
				};
			};
		};

		void printAbout(struct Node* current){
			Person p;
			p.printAbout(current);
			cout << " ; Title: " << current->gradeTitle;
			cout << " ; Department: " << current->majorDept << endl;
	};

};
int main() {
	int num;
	do {
		cout << "		Welcome to RU Record Management System\n";
		cout << "\n";
		cout << "	Press\n";
		cout << "	1 to create a new Student Record\n";
		cout << "	2 to create a new Teacher Record\n";
		cout << "	3 to view all records\n";
		cout << "	4 to Exit\n";
		cout << "\n";
		cout << "Enter your Choice:\n";
		cout << "\n";
		cin >> num;

		switch (num) {
			case 1: {
				Student student1;
				student1.setStudent();
				break;
			}
			case 2: {
				Teacher teacher1;
				teacher1.setTeacher();
				break;
			}
			case 3:{
				Student s;
				Teacher t;
				struct Node *current = head;
				while (current != NULL) {
					if (current->isStudent == true){
						s.printAbout(current);
					}
					else {
						t.printAbout(current);
					}
					current = current->next;
				}
				break;
			}
			default:
				break;
		}
	} while (num != 4);
	return 0;
};
