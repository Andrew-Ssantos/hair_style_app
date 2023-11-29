import 'dart:developer';
import 'package:hair_salon_app/core/db/collections/salon_service.dart';
import 'package:hair_salon_app/features/schedule/atom/schedule_client_atom.dart';
import 'package:hair_salon_app/features/schedule/presenter/state/schedule_salon_services_state.dart';

class ScheduleClientController {
  checkRepeatedService(SalonService service) {
    print(scheduleClientServiceList.value.contains(service));
    return switch (scheduleClientServiceList.value.contains(service)) {
      true => scheduleSalonServicesState.setValue(ScheduleSalonServicesStateFail('Erro: Serviço já incluído')),
      false => null
    };
    // ? scheduleSalonServicesState.setValue(ScheduleSalonServicesStateFail('Erro: Serviço já incluído'))
    // : null;
  }

  addSalonService(SalonService service) {
    checkRepeatedService(service);
    scheduleSalonServicesState.setValue(ScheduleSalonServicesStateLoading());
    try {
      scheduleClientServiceList.value.add(service);
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateSuccess(scheduleClientServiceList.value));
    } on Exception catch (e, s) {
      log('Erro ao adicionar o serviço ao agendamento', error: e, stackTrace: s);
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateFail('Erro ao adicionar o serviço ao agendamento'));
    }
  }

  deleteSalonService(SalonService service) {
    scheduleSalonServicesState.setValue(ScheduleSalonServicesStateLoading());
    try {
      scheduleClientServiceList.value.remove(service);
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateSuccess(scheduleClientServiceList.value));
    } on Exception catch (e, s) {
      log('Erro ao excluir serviço do agendamento', error: e, stackTrace: s);
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateFail('Erro ao excluir serviço do agendamento'));
    }
  }

  updateSalonService(int index, double price) {
    scheduleSalonServicesState.setValue(ScheduleSalonServicesStateLoading());
    try {
      scheduleClientServiceList.value[index].price = price;
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateSuccess(scheduleClientServiceList.value));
    } on Exception catch (e, s) {
      log('Erro ao atualizar serviço do agendamento', error: e, stackTrace: s);
      scheduleSalonServicesState.setValue(ScheduleSalonServicesStateFail('Erro ao atualizar serviço do agendamento'));
    }
  }
}
