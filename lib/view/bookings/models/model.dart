import 'package:petcare/view/bookings/booking_screen.dart';

import '../../../utils/app_images.dart';

class BookingData {
  final String userName;
  final String userProfileImage;
  final String location;
  final String service;
  final String contact;
  final String pickupTime;
  final String dropoffTime;
  final String petName;
  final String petBreed;
  final String petImage;
  final String date;
  final String price;
  final bool isRebooked;
  final String status;
  final double rating;
  final int totalReviews;
  final String petType;
  final String petWeight;
  final String petAge;
  final String petGender;
  final String dateOfBirth;
  final String adoptionDate;
  final String aboutPet;
  final String pottyBreak;
  final String energyLevel;
  final String feedingSchedule;
  final String canBeLeftAlone;
  final String medications;
  final String fill;
  final String vetName;
  final String clinicName;
  final String vetAddress;
  final String vetNumber;
  final String petInsuranceProvider;
  final String vetNote;
  final double bathingPrice;
  final double extendedCarePrice;
  final double additionalRate;
  final double total;

  BookingData({
    required this.userName,
    required this.userProfileImage,
    required this.location,
    required this.service,
    required this.contact,
    required this.pickupTime,
    required this.dropoffTime,
    required this.petName,
    required this.petBreed,
    required this.petImage,
    required this.date,
    required this.price,
    this.isRebooked = false,
    required this.status,
    required this.rating,
    required this.totalReviews,
    required this.petType,
    required this.petWeight,
    required this.petAge,
    required this.petGender,
    required this.dateOfBirth,
    required this.adoptionDate,
    required this.aboutPet,
    required this.pottyBreak,
    required this.energyLevel,
    required this.feedingSchedule,
    required this.canBeLeftAlone,
    required this.medications,
    required this.fill,
    required this.vetName,
    required this.clinicName,
    required this.vetAddress,
    required this.vetNumber,
    required this.petInsuranceProvider,
    required this.vetNote,
    required this.bathingPrice,
    required this.extendedCarePrice,
    required this.additionalRate,
    required this.total,
  });

  BookingData copyWith({
    bool? isRebooked,
    String? status,
  }) {
    return BookingData(
      userName: this.userName,
      userProfileImage: this.userProfileImage,
      location: this.location,
      service: this.service,
      contact: this.contact,
      pickupTime: this.pickupTime,
      dropoffTime: this.dropoffTime,
      petName: this.petName,
      petBreed: this.petBreed,
      petImage: this.petImage,
      date: this.date,
      price: this.price,
      isRebooked: isRebooked ?? this.isRebooked,
      status: status ?? this.status,
      rating: this.rating,
      totalReviews: this.totalReviews,
      petType: this.petType,
      petWeight: this.petWeight,
      petAge: this.petAge,
      petGender: this.petGender,
      dateOfBirth: this.dateOfBirth,
      adoptionDate: this.adoptionDate,
      aboutPet: this.aboutPet,
      pottyBreak: this.pottyBreak,
      energyLevel: this.energyLevel,
      feedingSchedule: this.feedingSchedule,
      canBeLeftAlone: this.canBeLeftAlone,
      medications: this.medications,
      fill: this.fill,
      vetName: this.vetName,
      clinicName: this.clinicName,
      vetAddress: this.vetAddress,
      vetNumber: this.vetNumber,
      petInsuranceProvider: this.petInsuranceProvider,
      vetNote: this.vetNote,
      bathingPrice: this.bathingPrice,
      extendedCarePrice: this.extendedCarePrice,
      additionalRate: this.additionalRate,
      total: this.total,
    );
  }
}

// --- DUMMY DATA ---
final List<BookingData> initialBookings = [
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppImages.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppImages.petImage,
    date: '02/09/2025',
    price: '\$99',
    isRebooked: true,
    status: 'On going',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '5kg',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: '',
    fill: 'ABCD Fill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppImages.tamimProfileImg,
    location: 'New York, NY',
    service: 'Pet Sitting',
    contact: '(229) 555-0109',
    pickupTime: '09:00 AM',
    dropoffTime: '05:00 PM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppImages.petImage,
    date: '07/09/2025',
    price: '\$150',
    isRebooked: false,
    status: 'Completed',
    rating: 4.5,
    totalReviews: 500,
    petType: 'Dog',
    petWeight: '25Kg',
    petAge: '5 Yer',
    petGender: 'Female',
    dateOfBirth: '5kg',
    adoptionDate: '10/12/2020',
    aboutPet: 'Very friendly and loves cuddles.',
    pottyBreak: 'Needs a potty break every 3 hours',
    energyLevel: 'Medium energy level',
    feedingSchedule: 'Needs to be fed twice a day',
    canBeLeftAlone: 'Can be left alone for 4 hours',
    medications: '',
    fill: 'ABCD Fill',
    vetName: 'Dr. John Smith',
    clinicName: 'City Vet',
    vetAddress: '10 Main St, Boston, MA',
    vetNumber: '(406) 555-0121',
    petInsuranceProvider: 'Rover',
    vetNote: 'Needs lots of playtime.',
    bathingPrice: 0.00,
    extendedCarePrice: 0.00,
    additionalRate: 0.00,
    total: 150.00,
  ),
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppImages.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppImages.petImage,
    date: '05/09/2025',
    price: '\$99',
    isRebooked: false,
    status: 'Cancelled',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '5kg',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: '',
    fill: 'ABCD Fill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppImages.tamimProfileImg,
    location: 'New York, NY',
    service: 'Cat Care',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppImages.petImage,
    date: '02/09/2025',
    price: '\$50',
    isRebooked: false,
    status: 'Upcoming',
    rating: 4.2,
    totalReviews: 800,
    petType: 'Cat',
    petWeight: '5Kg',
    petAge: '1 Yer 6Month',
    petGender: 'Female',
    dateOfBirth: '5kg',
    adoptionDate: '01/01/2024',
    aboutPet: 'Shy but sweet.',
    pottyBreak: 'Uses litter box',
    energyLevel: 'Low energy level',
    feedingSchedule: 'Free feeding kibble',
    canBeLeftAlone: 'Can be left alone for 8 hours',
    medications: '',
    fill: 'ABCD Fill',
    vetName: 'Dr. Mark Lee',
    clinicName: 'Feline Friends Clinic',
    vetAddress: '30 Catnip Ave, Boston, MA',
    vetNumber: '(406) 555-0122',
    petInsuranceProvider: 'CatGuard',
    vetNote: 'Loves tuna.',
    bathingPrice: 0.00,
    extendedCarePrice: 0.00,
    additionalRate: 0.00,
    total: 50.00,
  ),
];
