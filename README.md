
# EzyAid: Government Welfare Assistance System

<img src="https://github.com/user-attachments/assets/aef58223-7ac2-4739-91e5-3eb4d311e47e" alt="EZYAID" width="600"/>



##  Introduction

EzyAid is an intuitive digital platform aimed at enhancing citizen access to government welfare programs. Designed with inclusivity and accessibility in mind, EzyAid simplifies discovering and applying for welfare schemes. With real-time updates, personalized recommendations, and support for differently-abled users, it bridges the gap between government initiatives and the public, especially underserved communities.

---

##  Key Features

1. **Scheme Suggestions** – Personalized filtering based on user profiles and needs
2. **Real-Time Notifications** – Instant updates on scheme changes
3. **Geo-location Integration** – Maps and details for nearby MeeSeva offices
4. **Text-to-Speech Support** – Voice-based access for visually impaired users
5. **Multi-Language Interface** – Broad accessibility across regions
6. **Scheme Directory** – Comprehensive database of welfare schemes
7. **Cross-Platform App** – Built with Flutter for Android & iOS
8. **Favorites** – Save and manage preferred schemes
9. **Customizable Font Size** – Accessibility for users with visual difficulties
10. **Dashboard** – Visual analytics and statistics
11. **User Profiles** – Store basic details locally and persistently
12. **References** - Included helpful portal links organised by scheme/topic  

---

##  Technology Stack

| Layer            | Technology Used                    | Description                               |
| ---------------- | ---------------------------------- | ----------------------------------------- |
| Data Processing  | Apache Spark                       | ETL pipeline for scraped scheme data      |
| Database         | MySQL                              | Relational DB    scheme data storage      |
| CDC Listener     | Debezium                           | Captures real-time changes from MySQL     |
| Event Streaming  | Apache Kafka (Producer & Consumer) | Stream updates from Debezium to consumers |
| Caching Layer    | Redis                              | Quick access to updated data for notify   |
| Backend API      | Django (Python)                    | Business logic and API endpoints          |
| Containerization | Docker                             | Containerized deployment of services      |
| Frontend         | Flutter                            | Cross-platform mobile UI (Android/iOS)    |

---

##  System Architecture

![app flow](https://github.com/user-attachments/assets/e465c7a8-659c-40cf-bfad-09c6f45c07e8)


---

##  Future Scope

*  Push Notifications for Favorited Schemes
*  Secure Document Upload & Verification
*  Admin Panel for Scheme Management
*  User profile driven Scheme Recommendations
*  Expand Support to More Regional Languages

---

##  Conclusion

EzyAid reimagines the way government welfare schemes are accessed. By merging modern technologies with user-first design principles, the platform offers a scalable, accessible, and intelligent solution that can dramatically increase public participation in welfare programs.

---
## Project Files

-  **PPT**: [View Presentation](https://docs.google.com/presentation/d/1u7Us6bR-ovE8wo9uJMpf6t7bjyw5CKspJHs-GkWRJn4/edit?usp=sharing)
-  **Report**: [View Report](https://docs.google.com/document/d/1W6U71w5lloOy1WGpixur0Bmw08pmsizQNGjvziQLK7Q/edit?usp=sharing)

