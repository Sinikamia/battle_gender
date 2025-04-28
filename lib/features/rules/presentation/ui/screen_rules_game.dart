import 'package:auto_route/auto_route.dart';
import 'package:battle_gender/features/rules/presentation/ui/widgets/card_rules.dart';
import 'package:battle_gender/shared/widgets/app_bar/app_bar_universal.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScreenRulesGame extends StatefulWidget {
  const ScreenRulesGame({super.key});

  @override
  State<ScreenRulesGame> createState() => _ScreenRulesGameState();
}

class _ScreenRulesGameState extends State<ScreenRulesGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(
        onTap: () {
          context.router.pop();
        },
        text: "Правила",
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.01,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background_1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: const [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CardRules(
                        title: "Boys vs Girls",
                        text:
                            "Приглашаю вас принять участие в битве мужчин и женщин! В этой игре столкнутся мужская логика и женская интуиция, эрудиция и сообразительность. Женщины продемонстрируют свои знания в спорте и автомобилях, мужчины — в моде и кулинарии.\n\nПерфоратор против шпильки! Будёновка или бигуди! Пусть победит сильнейший пол!\n\n«Boys vs Girls» — отличная игра для компаний, вечеринок или романтических вечеров. Играть можно вдвоём, чтобы узнать друг друга, или одному, чтобы проверить свои знания противоположного пола.",
                        stepNumber: 0,
                        showNumber: false),
                    CardRules(
                        title: "Создайте игру",
                        text:
                            "Необходим как минимум один участник. \n\nДобавьте игроков, заполните их имена и выберите пол. Можно начинать игру.",
                        stepNumber: 1),
                    CardRules(
                        title: "Начало игры",
                        text:
                            "Выберите игрока, который будет ходить первым.\n\nВы можете выбрать вручную, либо нажать на кнопку и игрок будет выбран случайно.",
                        stepNumber: 2),
                    CardRules(
                        title: "Задания",
                        text:
                            "Полагаясь на свою интуицию, выберите карточку из списка, откройте её. Теперь придется отвечать на этот вопрос.\n\nПроявите всю вашу сообразительность, чтобы ответить.\n\nПереверните карточку, чтобы увидеть правильный ответ. Нажмите на кнопку «Правильно» или «Неправильно» в соотвествии с вашим ответом.",
                        stepNumber: 3),
                    CardRules(
                        title: "Оценка",
                        text:
                            "За каждый правильный ответ вы будете получать 1 очко. За ошибку у вас не будет ничего начисляться или списываться. Всего нужно набрать 20 очков.",
                        stepNumber: 4),
                    CardRules(
                        title: "Победа",
                        text:
                            "Играйте до тех пор, пока вам не надоест, или пока не закончатся вопросы.\n\nВ конце игры будет определен победитель и програвший",
                        stepNumber: 5),
                    CardRules(
                        title: "Веселой игры!",
                        stepNumber: 0,
                        showNumber: false),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
