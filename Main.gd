extends Node

export (PackedScene) var Coin   
export (int) var playtime

var level   #текущий уровень
var score   #очки
var time_left   #время за которое длится игра
var window_size #размер игрового окна
var window_margin = 50 #смещение игрового окна
var playing = false #игровая сессия не запущена

func _ready():
	randomize() #инициализируем генератор случайных чисел с некоторой случайной величиной
	window_size = get_viewport().get_visible_rect().size #Определяем видимую область приложения
	$Player.window_size = window_size #область ограничения для объекта "Игрок"
	$Player.hide() #делаем игрока невидимым
	$HUD/MarginContainer/ScoreLabel.hide()
	$HUD/MarginContainer/LevelLabel.hide()
	$HUD/MarginContainer/TimeLabel.hide()
	$HUD/MarginContainer2/Label.hide()
	$HUD/MarginContainer2/Label2.hide()
	$HUD/MarginContainer2/Label3.hide()
	$HUD/ButtonDown.hide()
	$HUD/ButtonLeft.hide()
	$HUD/ButtonRight.hide()
	$HUD/ButtonUp.hide()

func new_game():
	playing = true #игровая сессия запущена
	level = 1 
	score = 0
#	$Player.velocity = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start() #запуск таймера обратного отсчета
	spawn_coins() #спавн монеток

func spawn_coins():
	for i in range(level + 4):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
#		c.window_size = window_size
		c.position = Vector2(rand_range(window_margin, window_size.x-window_margin), rand_range(window_margin, window_size.y-window_margin-200))

func _process(delta):
	$HUD.update_score(score)
	$HUD.update_timer(time_left)
#мы все еще играем? и количество монеток равно нулю?
	if playing and $CoinContainer.get_child_count() == 0:
    	#тогда нужно увеличить уровень
		level += 1
		$HUD.update_level(level)
		#немного "подсластим" игровой процесс
		time_left += 10
		#спавним монетки
		spawn_coins()

func _on_GameTimer_timeout():
	time_left -= 1  #отсчет счетчика
	$HUD.update_timer(time_left)    #обновляем интерфейс счетчика
	if time_left <= 0:
	    game_over() #конец игры по окончанию счетчика

func game_over():
	$Player.velocity.x = 0
	$Player.velocity.y = 0
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()

func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)

func _on_Player_die():
	game_over()

func _on_Player_collision():
	game_over()
