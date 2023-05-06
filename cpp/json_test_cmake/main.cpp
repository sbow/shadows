#include <iostream>
#include <fstream>
#include <string>
#include <nlohmann/json.hpp>

int main() {
    // Cmake option: define location 
    #ifdef PARAMS_JSON_PATH
        std::string json_file_path = PARAMS_JSON_PATH;
    #else
        std::string json_file_path = "params.json";
    #endif

    // Open the file for reading
    std::ifstream in_file(json_file_path);

    // Check if file is open, implies existance
    if (!in_file.is_open()) {
        std::cout << "Error! Couldnt find params.json" << std::endl;
        return 1;
    }

    // Read contents of file stream to json object
    nlohmann::json json_obj;
    in_file >> json_obj;

    // Close the file
    in_file.close();

    // Access the parameters
    std::string name;
    try {
        name = json_obj.at("name");
    } catch (nlohmann::json::out_of_range &e) {
        std::cerr << "Error: 'name' not found in JSON file." << std::endl;
        return 1;
    }

    // Print the parameter
    std::cout << "from params.json name: " << name << std::endl;

    std::cout << "Hello, World!" << std::endl;
    return 0;
}