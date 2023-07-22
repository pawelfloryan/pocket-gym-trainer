import 'package:jwt_decoder/jwt_decoder.dart';

import '../main.dart';
import '../model/section.dart';
import '../pages/section_page.dart';
import '../services/section_services.dart';

List<Section> sections = <Section>[];
List<Section> newSections = <Section>[];
List<Section> newSectionsDelete = <Section>[];
Section section = Section();
Section sectionCreate = Section();
Section sectionDelete = Section();
Section sectionUpsert = Section();

String? jwtToken = RootPage.token;

late Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken!);
late String decodedUserId = decodedToken["id"];

int sectionIndex = SectionPage.sectionIndex;

class SectionProvider {
  void getData() async {
    sections = (await SectionService().getSection(jwtToken!, decodedUserId));
  }

  void createData() async {
    section = (await SectionService().createSection(sectionCreate))!;
    sections.add(section);
  }

  void deleteData(String sectionId) async {
    await SectionService().deleteSection(sectionId, jwtToken!);
    getData();
    sectionDelete.id = sectionId;
    newSectionsDelete = sections;
    newSectionsDelete.remove(sectionDelete);
  }

  void upsertData(String sectionId) async {
    section = (await SectionService().upsertSection(sectionId, sectionUpsert))!;
    getData();
    newSections = sections;
    newSections[sectionIndex].name = sectionUpsert.name;
  }
}
