
import 'package:eventos_app/shared/services/image_service.dart';
import 'package:image_picker/image_picker.dart';

class ImageServiceImpl extends ImageService{

  final ImagePicker _picker  = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo =  await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if( photo == null) return null;

    print('Tenemos una imagen ${ photo.path}');
    
    return photo.path;
  }
}




Future<XFile?> getImage() async {

  final ImagePicker picker = ImagePicker();
  // Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  return image;


}