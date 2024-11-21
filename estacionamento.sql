drop database nova_era;

create database nova_era;

use nova_era;

create table info_veiculo(
	placa varchar(7) not null primary key,
    fabricante varchar(20) not null, 
    modelo varchar(15) not null
);

create table horario_veiculo(
	id_horario int auto_increment not null primary key,
    horario_entrada time not null,
    horario_saida time not null,
    tempo_total time not null,
	placa varchar(7) not null,
    foreign key (placa) references info_veiculo(placa)
);

create table custos_veiculo(
	id_custo int auto_increment not null primary key,
    valor_hora int not null,
    tempo_total time not null,
    custo_total int not null,
    placa varchar(7) not null,
    foreign key (placa) references info_veiculo(placa),
    id_horario int not null,
    foreign key (id_horario) references horario_veiculo(id_horario)
);


INSERT INTO info_veiculo (placa, fabricante, modelo)
VALUES 
('ABC1234', 'Renault', 'Clio'),
('DEF5678', 'Volkswagen', 'Gol'),
('GHI9101', 'Fiat', 'Palio'),
('JKL2345', 'Chevrolet', 'Onix'),
('MNO6789', 'Hyundai', 'HB20'),
('PQR3456', 'Toyota', 'Corolla'),
('STU7890', 'Ford', 'Ka'),
('VWX1234', 'Nissan', 'Kicks'),
('YZA5678', 'Honda', 'Civic'),
('BCD9101', 'Jeep', 'Renegade');


INSERT INTO horario_veiculo (horario_entrada, horario_saida, tempo_total, placa)
VALUES
('08:00:00', '12:00:00', TIMEDIFF('12:00:00', '08:00:00'), 'ABC1234'),
('09:15:00', '17:45:00', TIMEDIFF('17:45:00', '09:15:00'), 'DEF5678'),
('10:30:00', '13:30:00', TIMEDIFF('13:30:00', '10:30:00'), 'GHI9101'),
('07:00:00', '16:00:00', TIMEDIFF('16:00:00', '07:00:00'), 'JKL2345'),
('08:45:00', '14:30:00', TIMEDIFF('14:30:00', '08:45:00'), 'MNO6789'),
('09:00:00', '18:00:00', TIMEDIFF('18:00:00', '09:00:00'), 'PQR3456'),
('06:30:00', '15:00:00', TIMEDIFF('15:00:00', '06:30:00'), 'STU7890'),
('08:15:00', '16:30:00', TIMEDIFF('16:30:00', '08:15:00'), 'VWX1234'),
('07:45:00', '15:15:00', TIMEDIFF('15:15:00', '07:45:00'), 'YZA5678'),
('10:00:00', '14:00:00', TIMEDIFF('14:00:00', '10:00:00'), 'BCD9101');

INSERT INTO custos_veiculo (valor_hora, tempo_total, custo_total, placa, id_horario)
VALUES
(10, '04:00:00', 0, 'ABC1234', 1),
(15, '08:30:00', 0, 'DEF5678', 2),
(12, '03:00:00', 0, 'GHI9101', 3),
(20, '09:00:00', 0, 'JKL2345', 4),
(18, '05:45:00', 0, 'MNO6789', 5),
(22, '09:00:00', 0, 'PQR3456', 6),
(14, '08:30:00', 0, 'STU7890', 7),
(16, '08:15:00', 0, 'VWX1234', 8),
(11, '07:30:00', 0, 'YZA5678', 9),
(19, '04:00:00', 0, 'BCD9101', 10);

SET SQL_SAFE_UPDATES = 0;

UPDATE custos_veiculo c
JOIN horario_veiculo h ON c.placa = h.placa
SET c.custo_total = (HOUR(TIMEDIFF(h.horario_saida, h.horario_entrada))) * c.valor_hora
WHERE c.id_horario = h.id_horario;

SET SQL_SAFE_UPDATES = 1;

select * from info_veiculo;
select * from horario_veiculo;
select * from custos_veiculo;
