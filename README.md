# Kidney Disease Diagnosis System Based on iOS (Swift + Google Firebase)

This repository contains the source code for an iOS-based expert system that assists in diagnosing kidney diseases. The system uses forward chaining for decision-making and follows the Spiral model for iterative development. The application is built using Swift and Google Firebase, employing the MVVM design pattern.

## Overview

This project aims to develop an expert system for diagnosing kidney diseases using iOS, Swift, and Google Firebase. The system utilizes forward chaining as the decision-making method and follows the Spiral model for application development.

## Key Concepts

- **Artificial Intelligence (AI)**: Utilizing reasoning or inference in AI to mimic human decision-making.
- **Inference Engine**: Decision-making system in AI, using forward chaining based on existing facts.
- **Expert System**: A system that mimics the reasoning of an expert to provide advice or diagnosis.
- **Forward Chaining**: A method within the inference engine that reasons forward from facts to conclusions.
- **MVVM**: Model-View-ViewModel, a pattern for application development separating business logic from UI presentation.
- **Spiral Model**: A method of software development focusing on iterative development and continuous testing.
- **iOS**: Operating system developed by Apple for its devices.
- **Swift**: Programming language developed by Apple for its ecosystem.
- **Firebase**: A NoSQL database management system developed by Google.

## Case Study

Developing an iOS-based expert system application to diagnose kidney diseases using forward chaining for decision-making and the Spiral model for development.

## Steps

### 1. Identify Problems & Goals

- **Target:** General Public.
- **Goals:** Assist in detecting and providing advice on kidney diseases based on reported symptoms.

### 2. Data Collection & Knowledge Acquisition from Experts

- **Collected Data:** List of kidney diseases, associated symptoms, and corresponding solutions.

#### Example:

| Disease | Symptoms | Solutions |
| --- | --- | --- |
| Chronic Kidney Disease (CKD) | Frequent fatigue, swelling in legs and hands, shortness of breath, nausea or vomiting, confusion, loss of appetite, frequent urination, headaches, high blood pressure, blood in urine | Kidney transplant or surgery |
| Acute Kidney Injury (AKI) | Decreased urine volume, swelling in legs, hands, and around eyes, shortness of breath, frequent fatigue, nausea and vomiting, confusion, chest pain or pressure | Intensive care |
| Kidney Stones | Severe pain on the side and back, below the ribs, pain spreading to the lower abdomen and groin, pain during urination, pink, red, or brown urine, cloudy or foul-smelling urine, nausea and vomiting | Shock wave lithotripsy (ESWL), surgery |
| Urinary Tract Infection (UTI) | Pain or burning sensation during urination, frequent urination with small volume, cloudy or bloody urine, strong-smelling urine, pelvic pain (in women) | Drink plenty of water |
| Glomerulonephritis | Pink or brown urine, high blood pressure, swelling in the face, hands, feet, and abdomen, fatigue | Treat infections, anti-inflammatory medication |
| Nephrotic Syndrome | Severe swelling around eyes and feet, foamy urine, weight gain due to fluid retention, loss of appetite | Low-salt diet, protein intake management, blood pressure management |
| Kidney Cysts | Pain in the back or side, pink or brown urine, frequent urinary tract infections, fever | Drainage, monitoring |
| Polycystic Kidney Disease (PKD) | High blood pressure, pain in the back or side, enlarged abdomen due to kidney enlargement, blood in urine, frequent urinary tract infections | Transplant, regular medical supervision |
| Diabetic Nephropathy | Swelling in ankles, feet, or hands, high blood pressure, foamy urine, unintended weight loss | Blood sugar control, blood pressure management, transplant |
| Hypertensive Nephropathy | High blood pressure hard to control, swelling in legs and ankles, fatigue, headaches | Regular check-ups, blood pressure management |

### 3. Building the Database with Google Firebase

- **Required Collections:**
  - **Users Collection:** Stores user data.
  - **Roles Collection:** Stores user roles.
  - **Diseases Collection:** Stores kidney disease data.
  - **Symptoms Collection:** Stores symptom data.
  - **Disease_Symptoms Collection:** Stores relationships between diseases and symptoms.
  - **Suggestions Collection:** Stores suggestions or solutions for each disease.
  - **UserDiseases Collection:** Stores diagnosis history for users.

### 4. Development and Testing

- **Start Development:** Proceed with application development by implementing the designed features.
- **Testing:** Conduct continuous and iterative testing following the Spiral model to ensure application quality.

## Implementation of Forward Chaining

- **Forward Chaining:**
  - Users input experienced symptoms.
  - The system checks these symptoms in the database.
  - Based on detected symptoms, the system provides diagnosis and corresponding advice.

## Tools and Technologies Used

- **Programming Language:** Swift
- **Framework:** UIKit or SwiftUI
- **Backend:** Google Firebase (Firestore, Authentication)
- **Design Pattern:** MVVM
- **Development Method:** Spiral 

## Getting Started

To get started with the Kidney Disease Diagnosis System project, follow these steps:

### 1. Clone the Repository

Clone the repository to your local machine using the following command:

```bash
https://github.com/pratama6624/My-Kidney.git
```

### 2. Install Dependencies

Ensure you have Xcode and CocoaPods installed. Then, install the project dependencies by running:

```bash
pod install
```

### 3. Open the Project

Open the .xcworkspace file in Xcode:
open KidneyDiseaseDiagnosis.xcworkspace

### 4. Configure Firebase

Add your GoogleService-Info.plist file to the project. This file is essential for Firebase integration and should be placed in the root of your Xcode project.

### 5. Run the Project

Select a simulator or connect a physical device in Xcode. Then, click the run button to build and run the application.

## For Me

Good luck in developing this expert system application.

## Preview On IPhone

<img width="1139" alt="Screenshot 2024-10-30 at 11 04 53 PM" src="https://github.com/user-attachments/assets/e86cd504-9141-4e9c-8885-d8d5ea7420af">
